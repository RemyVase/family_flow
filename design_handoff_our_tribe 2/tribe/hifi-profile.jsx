/* hifi-profile.jsx — Profil & paramètres */

const PALETTE = ['#C25A38', '#3E6AA6', '#2E8461', '#6C57A6', '#B5843A', '#B0517E'];

const TRASH = <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><path d="M4 7h16M10 7V5a1 1 0 011-1h2a1 1 0 011 1v2M6 7l1 13a1 1 0 001 1h8a1 1 0 001-1l1-13"/></svg>;

/* Une ligne de membre : tap = palette de couleur (si autorisé), swipe = retirer (chef, sauf soi) */
function MemberRow({ m, hex, canColor, canRemove, palette, memberColors, onSetColor, onRemove }) {
  const [open, setOpen] = React.useState(false);   // palette ouverte
  const [dx, setDx] = React.useState(0);           // décalage swipe
  const [confirm, setConfirm] = React.useState(false);
  const drag = React.useRef(null);

  const down = (e) => { if (!canRemove) return; drag.current = { x: e.clientX, dx0: dx <= -80 ? -88 : 0 }; };
  const move = (e) => {
    if (!drag.current) return;
    const d = Math.max(-96, Math.min(0, drag.current.dx0 + (e.clientX - drag.current.x)));
    setDx(d);
  };
  const up = () => { if (!drag.current) return; setDx(dx < -44 ? -88 : 0); drag.current = null; };

  const tapRow = () => {
    if (dx < 0) { setDx(0); return; }        // referme le swipe
    if (canColor) setOpen((o) => !o);
  };

  return (
    <div className="pf-swipe">
      {canRemove && !confirm && (
        <button className="pf-swipe-del" onClick={() => { setConfirm(true); setDx(0); }} tabIndex={-1}>
          {React.cloneElement(TRASH, { style: { width: 17, height: 17 } })}Retirer
        </button>
      )}
      <div className="pf-swipe-front" style={{ transform: `translateX(${dx}px)` }}
        onPointerDown={down} onPointerMove={move} onPointerUp={up} onPointerLeave={up}>
        <button className={'pf-member' + (open ? ' editing' : '')} onClick={tapRow}>
          <span className="pf-mava" style={{ background: `var(--m-${m.color})`, color: '#fff' }}>{m.initial}</span>
          <span className="pf-mname">{m.name}{m.id === 'lea' && <span className="lead-you"> · chef</span>}{m.id === CURRENT_USER && m.id !== 'lea' && <span className="lead-you"> · moi</span>}</span>
          <span className="pf-dot" style={{ background: `var(--m-${m.color})` }} />
          {canColor && React.cloneElement(HIcon.pencil, { style: { width: 14, height: 14, stroke: 'var(--ink-3)' } })}
        </button>
        {open && (
          <div className="pf-palette">
            {palette.map((c) => {
              const on = (memberColors[m.id] || '').toLowerCase() === c.toLowerCase();
              return (
                <button key={c} className={'pf-swatch' + (on ? ' on' : '')} style={{ background: c }}
                  onClick={() => { onSetColor(m.id, c); setOpen(false); }} aria-label={c}>
                  {on && React.cloneElement(HIcon.check, { style: { width: 15, height: 15, stroke: '#fff', strokeWidth: 3.4, fill: 'none' } })}
                </button>
              );
            })}
          </div>
        )}
      </div>

      {confirm && (
        <div className="pf-confirm">
          <span>Retirer <strong>{m.name}</strong> de la tribu ?</span>
          <div className="pf-confirm-btns">
            <button className="pf-confirm-no" onClick={() => { setConfirm(false); setDx(0); }}>Annuler</button>
            <button className="pf-confirm-yes" onClick={() => onRemove(m.id)}>Retirer</button>
          </div>
        </div>
      )}
    </div>
  );
}

const CURRENT_USER = 'lea';

function Profile({ tw, onNav, cvars, memberColors, onSetColor, onOpenSetting, onLogout, onEdit, members: membersProp, onRemoveMember, isChef, onLeave }) {
  const accent = tw.accent;
  const members = membersProp || window.MEMBERS || [];
  const chef = isChef !== false;
  const [leaving, setLeaving] = React.useState(false);
  const settings = [
    { key: 'notif',    ic: 'bell',   label: 'Notifications',        detail: 'Activées' },
    { key: 'reminders', ic: 'repeat', label: 'Récurrences', detail: null },
    { key: 'rewards',  ic: 'gift',   label: 'Récompenses',           detail: '4 objectifs' },
    { key: 'help',     ic: 'help',   label: 'Aide',                  detail: null },
  ];

  return (
    <div className="app" style={{ ...cvars, '--accent': accent, '--r': tw.radius + 'px' }}>
      <div className="scroll">
        <div className="hdr">
          <div>
            <div className="date">Mon compte</div>
            <div className="hi">Profil</div>
          </div>
        </div>

        {/* user card */}
        <div className="pf-user">
          <div className="pf-ava" style={{ background: 'var(--m-lea-soft)', color: 'var(--m-lea)', borderColor: 'color-mix(in oklab, var(--m-lea) 35%, #fff)' }}>L</div>
          <div style={{ flex: 1, minWidth: 0 }}>
            <div className="pf-name">Léa</div>
            <div className="pf-mail">lea@ourtribe.be</div>
          </div>
          <button className="pf-edit" onClick={onEdit}>{React.cloneElement(HIcon.pencil, { style: { width: 16, height: 16 } })}Éditer</button>
        </div>

        {/* family */}
        <div className="dt-label">La tribu Dubois</div>
        <div className="pf-card">
          <div className="pf-card-row">
            <span className="pf-card-l">Membres · {members.length}</span>
            {chef && <span className="pf-manage">Gérer</span>}
          </div>
          <div className="pf-members">
            {members.map((m) => {
              const isSelf = m.id === CURRENT_USER;
              return (
                <MemberRow key={m.id} m={m}
                  canColor={chef || isSelf}
                  canRemove={chef && !isSelf}
                  palette={PALETTE}
                  memberColors={memberColors}
                  onSetColor={onSetColor}
                  onRemove={onRemoveMember} />
              );
            })}
          </div>
          <div className="pf-hint">{React.cloneElement(HIcon.sparkle, { style: { width: 13, height: 13 } })} {chef
            ? 'Touche une pastille pour changer la couleur · glisse une ligne pour retirer un membre'
            : 'Touche ta pastille pour changer ta couleur — elle s’applique partout'}</div>
        </div>

        {/* invite code */}
        <div className="pf-code" style={{ background: `linear-gradient(135deg, color-mix(in oklab, ${accent} 12%, #FFFDFA), color-mix(in oklab, ${accent} 26%, #FFF6EE))`, borderColor: `color-mix(in oklab, ${accent} 22%, #fff)` }}>
          <div style={{ flex: 1, minWidth: 0 }}>
            <div className="pf-code-l">Code d’invitation</div>
            <div className="pf-code-v" style={{ color: `color-mix(in oklab, ${accent} 62%, #1B141F)` }}>4KP-92Q</div>
          </div>
          <button className="pf-share" style={{ color: `color-mix(in oklab, ${accent} 72%, #000 6%)` }}>{React.cloneElement(HIcon.share, { style: { width: 16, height: 16 } })}Partager</button>
        </div>

        {/* settings list */}
        <div className="dt-label" style={{ marginTop: 20 }}>Paramètres</div>
        <div className="pf-list">
          {settings.map((s, i) => (
            <button key={s.label} className="pf-srow" style={i === settings.length - 1 ? { borderBottom: 'none' } : null} onClick={() => onOpenSetting && onOpenSetting(s.key)}>
              <span className="pf-sic">{React.cloneElement(HIcon[s.ic], { style: { width: 18, height: 18 } })}</span>
              <span className="pf-slabel">{s.label}</span>
              {s.detail && <span className="pf-sdetail">{s.detail}</span>}
              {React.cloneElement(HIcon.chevR, { style: { width: 16, height: 16, stroke: 'var(--ink-3)' } })}
            </button>
          ))}
        </div>

        {/* quitter / logout */}
        <button className="pf-leave" onClick={() => setLeaving(true)}>{React.cloneElement(HIcon.logout, { style: { width: 18, height: 18 } })}Quitter la tribu</button>
        <button className="pf-logout" onClick={() => { if (onLogout) return onLogout(); window.location.href = 'Our Tribe - Onboarding.html'; }}>{React.cloneElement(HIcon.logout, { style: { width: 18, height: 18 } })}Se déconnecter</button>
        <div className="pf-version">Our Tribe · v1.0</div>
      </div>

      {leaving && (
        <LeaveSheet chef={chef} members={members} currentUser={CURRENT_USER}
          onCancel={() => setLeaving(false)}
          onConfirm={() => { if (onLeave) return onLeave(); window.location.href = 'Our Tribe - Onboarding.html'; }} />
      )}

      <TabBar active="profile" onNav={onNav} />
    </div>
  );
}

/* ---------- Feuille « Quitter la tribu » ---------- */
function LeaveSheet({ chef, members, currentUser, onCancel, onConfirm }) {
  const others = members.filter((m) => m.id !== currentUser);
  const soloChef = chef && others.length === 0;
  const needsNewChef = chef && others.length > 0;
  const [newChef, setNewChef] = React.useState(null);
  const canLeave = !needsNewChef || !!newChef;

  return (
    <div className="pf-sheet-scrim" onClick={onCancel}>
      <div className="pf-sheet" onClick={(e) => e.stopPropagation()}>
        <div className="pf-sheet-grip" />
        {needsNewChef ? (
          <React.Fragment>
            <div className="pf-sheet-warn">{React.cloneElement(HIcon.sparkle, { style: { width: 18, height: 18, stroke: '#B77400' } })}
              <span>Tu es le chef de la tribu. Avant de partir, choisis qui prend le relais.</span>
            </div>
            <div className="pf-sheet-title">Nouveau chef de tribu</div>
            <div className="pf-chooser">
              {others.map((m) => {
                const on = newChef === m.id;
                return (
                  <button key={m.id} className={'pf-choose' + (on ? ' on' : '')} onClick={() => setNewChef(m.id)}
                    style={on ? { borderColor: `var(--m-${m.color})`, background: `var(--m-${m.color}-soft)` } : null}>
                    <span className="pf-mava" style={{ background: `var(--m-${m.color})`, color: '#fff' }}>{m.initial}</span>
                    <span className="pf-mname">{m.name}</span>
                    <span className={'pf-radio' + (on ? ' on' : '')} style={on ? { borderColor: `var(--m-${m.color})`, background: `var(--m-${m.color})` } : null}>{on && React.cloneElement(HIcon.check, { style: { width: 12, height: 12, stroke: '#fff', strokeWidth: 3.4, fill: 'none' } })}</span>
                  </button>
                );
              })}
            </div>
          </React.Fragment>
        ) : (
          <React.Fragment>
            <div className="pf-sheet-title" style={{ marginTop: 4 }}>{soloChef ? 'Supprimer la tribu ?' : 'Quitter la tribu Dubois ?'}</div>
            <p className="pf-sheet-sub">{soloChef
              ? 'Tu es le dernier membre. Quitter supprimera définitivement la tribu et ses tâches.'
              : 'Tu ne verras plus ses tâches et ton score sera retiré du classement.'}</p>
          </React.Fragment>
        )}
        <div className="pf-sheet-btns">
          <button className="pf-sheet-cancel" onClick={onCancel}>Annuler</button>
          <button className="pf-sheet-leave" disabled={!canLeave}
            style={canLeave ? null : { opacity: .5, pointerEvents: 'none' }}
            onClick={onConfirm}>{needsNewChef ? 'Nommer & quitter' : (soloChef ? 'Supprimer' : 'Quitter')}</button>
        </div>
      </div>
    </div>
  );
}

window.Profile = Profile;

/* ---------- Édition de profil ---------- */
function ProfileEdit({ tw, cvars, memberColors, onSetColor, onBack }) {
  const accent = tw.accent;
  const [name, setName] = React.useState('Léa');
  const [email, setEmail] = React.useState('lea@ourtribe.be');
  const myColor = (memberColors && memberColors.lea) || '#C25A38';
  const PAL = ['#C25A38', '#3E6AA6', '#2E8461', '#6C57A6', '#B5843A', '#B0517E'];

  return (
    <div className="app" style={{ ...cvars, '--accent': accent, '--r': tw.radius + 'px' }}>
      <div className="scroll" style={{ paddingBottom: 104 }}>
        <button className="ob-back" onClick={onBack} aria-label="Retour">{HIcon.chevL}</button>
        <h1 className="ob-title">Modifier le profil</h1>
        <p className="ob-sub">Ton nom et ta couleur apparaissent partout dans la tribu.</p>

        {/* avatar preview */}
        <div className="pe-avatar">
          <span className="pe-ava" style={{ background: myColor, color: '#fff' }}>{(name.trim()[0] || 'L').toUpperCase()}</span>
          <button className="pe-photo-btn">{React.cloneElement(HIcon.camera || HIcon.pencil, { style: { width: 15, height: 15 } })}Changer la photo</button>
        </div>

        <div className="cf-group">
          <label className="cf-label">Prénom</label>
          <input className="cf-input" value={name} onChange={(e) => setName(e.target.value)} placeholder="Ton prénom" />
        </div>
        <div className="cf-group">
          <label className="cf-label">E-mail</label>
          <input className="cf-input" type="email" value={email} onChange={(e) => setEmail(e.target.value)} placeholder="toi@ourtribe.be" />
        </div>

        <div className="cf-group">
          <label className="cf-label">Ma couleur</label>
          <div className="ob-swatches">
            {PAL.map((hex) => {
              const on = myColor.toLowerCase() === hex.toLowerCase();
              return (
                <button key={hex} className={'pf-swatch' + (on ? ' on' : '')} style={{ background: hex }}
                  onClick={() => onSetColor && onSetColor('lea', hex)} aria-label={hex}>
                  {on && React.cloneElement(HIcon.check, { style: { width: 15, height: 15, stroke: '#fff', strokeWidth: 3.4, fill: 'none' } })}
                </button>
              );
            })}
          </div>
        </div>

        <div className="dt-label" style={{ marginTop: 8 }}>Sécurité</div>
        <button className="pf-srow" style={{ borderRadius: 15, border: '1px solid var(--line)', width: '100%' }}>
          <span className="pf-sic">{React.cloneElement(HIcon.key || HIcon.pencil, { style: { width: 18, height: 18 } })}</span>
          <span className="pf-slabel">Changer le mot de passe</span>
          {React.cloneElement(HIcon.chevR, { style: { width: 16, height: 16, stroke: 'var(--ink-3)' } })}
        </button>
      </div>

      <div className="dt-action">
        <button className="dt-btn" style={{ background: accent }} onClick={onBack}>
          Enregistrer{React.cloneElement(HIcon.check, { style: { width: 20, height: 20, stroke: '#fff', strokeWidth: 2.6, fill: 'none' } })}
        </button>
      </div>
    </div>
  );
}

window.ProfileEdit = ProfileEdit;
