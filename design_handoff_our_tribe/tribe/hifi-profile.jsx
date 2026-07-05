/* hifi-profile.jsx — Profil & paramètres */

const PALETTE = ['#F07557', '#4FA3E3', '#3FB088', '#8E7CE0', '#F0A93C', '#E86FA6', '#5FB0C9', '#7E9B54'];

function Profile({ tw, onNav, cvars, memberColors, onSetColor, onOpenSetting, onLogout }) {
  const accent = tw.accent;
  const members = window.MEMBERS || [];
  const [editing, setEditing] = React.useState(null);
  const settings = [
    { key: 'notif',    ic: 'bell',   label: 'Notifications',        detail: 'Activées' },
    { key: 'reminders', ic: 'repeat', label: 'Récurrences & rappels', detail: null },
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
            <div className="pf-mail">lea@famille.be</div>
          </div>
          <button className="pf-edit">{React.cloneElement(HIcon.pencil, { style: { width: 16, height: 16 } })}Éditer</button>
        </div>

        {/* family */}
        <div className="dt-label">La tribu Dubois</div>
        <div className="pf-card">
          <div className="pf-card-row">
            <span className="pf-card-l">Membres · {members.length || 4}</span>
            <span className="pf-manage">Gérer</span>
          </div>
          <div className="pf-members">
            {members.map((m) => (
              <div key={m.id} className="pf-member-wrap">
                <button className={'pf-member' + (editing === m.id ? ' editing' : '')} onClick={() => setEditing(editing === m.id ? null : m.id)}>
                  <span className="pf-mava" style={{ background: `var(--m-${m.color})`, color: '#fff' }}>{m.initial}</span>
                  <span className="pf-mname">{m.name}{m.id === 'lea' && <span className="lead-you"> · chef</span>}</span>
                  <span className="pf-dot" style={{ background: `var(--m-${m.color})` }} />
                  {React.cloneElement(HIcon.pencil, { style: { width: 14, height: 14, stroke: 'var(--ink-3)' } })}
                </button>
                {editing === m.id && (
                  <div className="pf-palette">
                    {PALETTE.map((hex) => {
                      const on = (memberColors[m.id] || '').toLowerCase() === hex.toLowerCase();
                      return (
                        <button key={hex} className={'pf-swatch' + (on ? ' on' : '')} style={{ background: hex }}
                          onClick={() => { onSetColor(m.id, hex); setEditing(null); }} aria-label={hex}>
                          {on && React.cloneElement(HIcon.check, { style: { width: 15, height: 15, stroke: '#fff', strokeWidth: 3.4, fill: 'none' } })}
                        </button>
                      );
                    })}
                  </div>
                )}
              </div>
            ))}
          </div>
          <div className="pf-hint">{React.cloneElement(HIcon.sparkle, { style: { width: 13, height: 13 } })} En tant que chef de tribu, touche une pastille pour changer la couleur</div>
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

        {/* logout */}
        <button className="pf-logout" onClick={() => { if (onLogout) return onLogout(); window.location.href = 'Family Home - Onboarding.html'; }}>{React.cloneElement(HIcon.logout, { style: { width: 18, height: 18 } })}Se déconnecter</button>
        <div className="pf-version">Family Home · v1.0</div>
      </div>

      <TabBar active="profile" onNav={onNav} />
    </div>
  );
}

window.Profile = Profile;
