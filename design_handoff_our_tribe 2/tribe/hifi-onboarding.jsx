/* tribe/hifi-onboarding.jsx — Onboarding « Our Tribe » (pré-connexion) */

const OB = {
  home:  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><path d="M3.5 11L12 4l8.5 7"/><path d="M5.5 9.5V20h13V9.5"/></svg>,
  users: <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><circle cx="9" cy="8" r="3.2"/><path d="M3.5 19a5.5 5.5 0 0111 0"/><path d="M16 5.2a3.2 3.2 0 010 5.6M20.5 19a5.5 5.5 0 00-4-5.3"/></svg>,
  key:   <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><circle cx="8" cy="8" r="4.5"/><path d="M11 11l8 8M16 16l2-2M19 19l2-2"/></svg>,
  chevL: <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.4" strokeLinecap="round" strokeLinejoin="round"><path d="M15 5l-7 7 7 7"/></svg>,
  arrow: <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.4" strokeLinecap="round" strokeLinejoin="round"><path d="M5 12h14M13 6l6 6-6 6"/></svg>,
  check: <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3" strokeLinecap="round" strokeLinejoin="round"><path d="M5 12.5l4.5 4.5L19 7"/></svg>,
  copy:  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><rect x="8" y="8" width="12" height="12" rx="3"/><path d="M16 8V6a2 2 0 00-2-2H6a2 2 0 00-2 2v8a2 2 0 002 2h2"/></svg>,
  share: <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><path d="M12 15V4M8.5 7.5L12 4l3.5 3.5"/><path d="M6 12v7a1 1 0 001 1h10a1 1 0 001-1v-7"/></svg>,
  heart: <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><path d="M12 20s-7-4.6-7-9.5A3.8 3.8 0 0112 7a3.8 3.8 0 017 3.5c0 4.9-7 9.5-7 9.5z"/></svg>,
};

/* palette = couleurs signature de la tribu */
const OB_PALETTE = ['#C25A38', '#3E6AA6', '#2E8461', '#6C57A6', '#B5843A', '#B0517E'];

function ObField({ label, type = 'text', value, onChange, placeholder, opt }) {
  return (
    <div className="cf-group">
      <label className="cf-label">{label}{opt && <span className="cf-opt"> optionnel</span>}</label>
      <input className="cf-input" type={type} value={value} onChange={(e) => onChange(e.target.value)} placeholder={placeholder} />
    </div>
  );
}

function PrimaryBtn({ children, onClick, disabled, accent, ic }) {
  return (
    <button className="dt-btn" disabled={disabled} onClick={onClick}
      style={disabled ? { background: 'var(--line)', color: 'var(--ink-3)', boxShadow: 'none' }
        : { background: accent }}>
      {children}{ic && React.cloneElement(OB[ic], { style: { width: 20, height: 20, stroke: '#fff' } })}
    </button>
  );
}

/* logo = jeton hexagonal monogramme OT */
function TribeMark({ accent, children }) {
  return (
    <div className="ob-logo" style={{ background: accent }}>
      {children || <span className="ob-logo-mono">OT</span>}
    </div>
  );
}

function AvatarCluster() {
  const set = [['L', '#C25A38'], ['M', '#2E8461'], ['P', '#3E6AA6'], ['T', '#6C57A6']];
  return (
    <div className="ob-cluster">
      {set.map(([i, c], k) => (
        <span key={k} className="ob-cl-ava" style={{ background: c, marginLeft: k ? -14 : 0, zIndex: 10 - k }}>{i}</span>
      ))}
    </div>
  );
}

function Onboarding({ onEnter }) {
  const accent = '#2F6D4E';
  const [stack, setStack] = React.useState(['welcome']);
  const step = stack[stack.length - 1];
  const go = (s) => setStack((st) => [...st, s]);
  const back = () => setStack((st) => st.length > 1 ? st.slice(0, -1) : st);

  const [firstName, setFirstName] = React.useState('');
  const [email, setEmail] = React.useState('');
  const [pwd, setPwd] = React.useState('');
  const [famName, setFamName] = React.useState('');
  const [famColor, setFamColor] = React.useState('#2E8461');
  const [code, setCode] = React.useState(['', '', '', '', '', '']);

  const CODE = '4KP92Q';
  const enterApp = () => { if (onEnter) return onEnter(); window.location.href = 'Our Tribe.html'; };

  const Header = ({ title, sub }) => (
    <React.Fragment>
      <button className="ob-back" onClick={back}>{OB.chevL}</button>
      <h1 className="ob-title">{title}</h1>
      {sub && <p className="ob-sub">{sub}</p>}
    </React.Fragment>
  );

  let body, footer;

  if (step === 'welcome') {
    body = (
      <div className="ob-welcome">
        <TribeMark accent={accent} />
        <h1 className="ob-brand">Our Tribe</h1>
        <p className="ob-tag">Les tâches de la maison,<br/>toute la tribu au même endroit.</p>
        <AvatarCluster />
      </div>
    );
    footer = (
      <div className="ob-foot-col">
        <PrimaryBtn accent={accent} onClick={() => go('signup')} ic="arrow">Créer mon compte</PrimaryBtn>
        <button className="ob-link" onClick={() => go('signin')}>J’ai déjà un compte</button>
      </div>
    );
  }

  else if (step === 'signup') {
    body = (
      <React.Fragment>
        <Header title="Créer un compte" sub="On commence par toi." />
        <ObField label="Ton prénom" value={firstName} onChange={setFirstName} placeholder="Ex. Léa" />
        <ObField label="E-mail" type="email" value={email} onChange={setEmail} placeholder="lea@ourtribe.be" />
        <ObField label="Mot de passe" type="password" value={pwd} onChange={setPwd} placeholder="Choisis un mot de passe" />
        <div className="ob-note">{React.cloneElement(OB.heart, { style: { width: 15, height: 15, stroke: accent } })}<span>Ton prénom s’affichera sur tes tâches et dans le classement de la tribu.</span></div>
      </React.Fragment>
    );
    footer = <PrimaryBtn accent={accent} disabled={!firstName.trim() || !email.trim()} onClick={() => go('choose')} ic="arrow">Continuer</PrimaryBtn>;
  }

  else if (step === 'signin') {
    body = (
      <React.Fragment>
        <Header title="Bon retour" sub="Connecte-toi à ton compte." />
        <ObField label="E-mail" type="email" value={email} onChange={setEmail} placeholder="lea@ourtribe.be" />
        <ObField label="Mot de passe" type="password" value={pwd} onChange={setPwd} placeholder="••••••••" />
        <button className="ob-link" style={{ textAlign: 'left', marginTop: 2 }}>Mot de passe oublié ?</button>
      </React.Fragment>
    );
    footer = <PrimaryBtn accent={accent} disabled={!email.trim() || !pwd.trim()} onClick={enterApp} ic="arrow">Se connecter</PrimaryBtn>;
  }

  else if (step === 'choose') {
    body = (
      <React.Fragment>
        <Header title="Ta tribu" sub="Rejoins la tribu de quelqu’un, ou crée la tienne." />
        <button className="ob-choice" onClick={() => go('create')} style={{ borderColor: accent, background: `color-mix(in oklab, ${accent} 8%, #fff)` }}>
          <span className="ob-choice-ic" style={{ background: `color-mix(in oklab, ${accent} 16%, #fff)`, color: accent }}>{OB.users}</span>
          <span className="ob-choice-txt"><span className="ob-choice-t">Créer une tribu</span><span className="ob-choice-d">Je démarre et j’invite les autres</span></span>
          {React.cloneElement(OB.arrow, { style: { width: 18, height: 18, stroke: accent } })}
        </button>
        <button className="ob-choice" onClick={() => go('join')}>
          <span className="ob-choice-ic" style={{ background: 'var(--sky-soft)', color: 'var(--sky)' }}>{OB.key}</span>
          <span className="ob-choice-txt"><span className="ob-choice-t">Rejoindre avec un code</span><span className="ob-choice-d">On m’a partagé un code d’invitation</span></span>
          {React.cloneElement(OB.arrow, { style: { width: 18, height: 18, stroke: 'var(--ink-3)' } })}
        </button>
      </React.Fragment>
    );
  }

  else if (step === 'create') {
    body = (
      <React.Fragment>
        <Header title="Nouvelle tribu" sub="Donne-lui un nom et une couleur." />
        <ObField label="Nom de la tribu" value={famName} onChange={setFamName} placeholder="Ex. La tribu Dubois" />
        <div className="cf-group">
          <label className="cf-label">Couleur de la tribu</label>
          <div className="ob-swatches">
            {OB_PALETTE.map((hex) => (
              <button key={hex} className={'pf-swatch' + (famColor === hex ? ' on' : '')} style={{ background: hex }} onClick={() => setFamColor(hex)}>
                {famColor === hex && React.cloneElement(OB.check, { style: { width: 15, height: 15, stroke: '#fff' } })}
              </button>
            ))}
          </div>
        </div>
      </React.Fragment>
    );
    footer = <PrimaryBtn accent={accent} disabled={!famName.trim()} onClick={() => go('invite')} ic="arrow">Créer la tribu</PrimaryBtn>;
  }

  else if (step === 'invite') {
    body = (
      <React.Fragment>
        <button className="ob-back" onClick={() => setStack(['welcome'])} aria-label="Fermer">{OB.chevL}</button>
        <div className="ob-badge" style={{ background: `color-mix(in oklab, ${famColor} 16%, #fff)`, color: `color-mix(in oklab, ${famColor} 70%, #000 10%)` }}>Tribu créée</div>
        <h1 className="ob-title">Invite ta tribu</h1>
        <p className="ob-sub">Partage ce code. Chacun l’entre après son inscription.</p>
        <div className="ob-code-card" style={{ background: `color-mix(in oklab, ${famColor} 9%, #fff)`, borderColor: `color-mix(in oklab, ${famColor} 24%, #fff)` }}>
          <div className="ob-code-l">Code d’invitation</div>
          <div className="ob-code-v" style={{ color: `color-mix(in oklab, ${famColor} 68%, #1B141F)` }}>4KP-92Q</div>
          <div className="ob-code-btns">
            <button className="ob-code-btn">{React.cloneElement(OB.copy, { style: { width: 16, height: 16 } })}Copier</button>
            <button className="ob-code-btn">{React.cloneElement(OB.share, { style: { width: 16, height: 16 } })}Partager</button>
          </div>
        </div>
        <div className="ob-note"><span>Tu pourras toujours retrouver ce code dans ton profil.</span></div>
      </React.Fragment>
    );
    footer = <PrimaryBtn accent={accent} onClick={() => go('done')} ic="arrow">Continuer</PrimaryBtn>;
  }

  else if (step === 'join') {
    const filled = code.filter(Boolean).length;
    const setDigit = (i, v) => setCode((c) => c.map((x, k) => k === i ? v.slice(-1).toUpperCase() : x));
    body = (
      <React.Fragment>
        <Header title="Rejoindre" sub="Entre le code que ta tribu t’a partagé." />
        <div className="ob-code-inputs">
          {code.map((d, i) => (
            <input key={i} className={'ob-cbox' + (d ? ' filled' : '')} value={d} maxLength={1}
              onChange={(e) => setDigit(i, e.target.value)}
              style={d ? { borderColor: accent } : null} />
          ))}
        </div>
        <button className="ob-link" style={{ marginTop: 4 }} onClick={() => setCode(CODE.split(''))}>Coller « 4KP-92Q »</button>
        {filled === 6 && (
          <div className="ob-found" style={{ borderColor: `color-mix(in oklab, ${accent} 30%, #fff)`, background: `color-mix(in oklab, ${accent} 8%, #fff)` }}>
            <span className="ob-found-ava" style={{ background: accent }}>D</span>
            <div style={{ flex: 1 }}><div className="ob-found-n">La tribu Dubois</div><div className="ob-found-s">4 membres</div></div>
            <span className="ob-found-check" style={{ background: accent }}>{React.cloneElement(OB.check, { style: { width: 14, height: 14, stroke: '#fff' } })}</span>
          </div>
        )}
      </React.Fragment>
    );
    footer = <PrimaryBtn accent={accent} disabled={filled < 6} onClick={() => go('done')} ic="arrow">Rejoindre la tribu</PrimaryBtn>;
  }

  else if (step === 'done') {
    body = (
      <div className="ob-welcome">
        <TribeMark accent={accent}>{React.cloneElement(OB.check, { style: { width: 40, height: 40, stroke: '#fff' } })}</TribeMark>
        <h1 className="ob-brand" style={{ fontSize: 28 }}>C’est parti, {firstName || 'Léa'}</h1>
        <p className="ob-tag">Ta tribu est prête.<br/>À vous de jouer, une tâche à la fois.</p>
      </div>
    );
    footer = <PrimaryBtn accent={accent} onClick={enterApp} ic="arrow">Entrer dans Our Tribe</PrimaryBtn>;
  }

  const centered = step === 'welcome' || step === 'done';

  return (
    <div className="app" style={{ '--accent': accent, '--r': '16px' }}>
      <div className="scroll" style={{ paddingTop: 58, paddingBottom: footer ? 104 : 40, display: centered ? 'flex' : 'block', flexDirection: 'column', justifyContent: 'center' }}>
        {body}
      </div>
      {footer && <div className="dt-action">{footer}</div>}
    </div>
  );
}

window.Onboarding = Onboarding;
