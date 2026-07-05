/* hifi-settings.jsx — Sous-écrans Paramètres : Récompenses · Récurrences & rappels */

/* ---------- petits composants partagés ---------- */
function SetHeader({ title, sub, onBack }) {
  return (
    <div style={{ marginBottom: 16 }}>
      <button className="ob-back" onClick={onBack} aria-label="Retour">{HIcon.chevL}</button>
      <h1 className="ob-title">{title}</h1>
      {sub && <p className="ob-sub" style={{ marginBottom: 0 }}>{sub}</p>}
    </div>
  );
}

function Toggle({ on, onChange, accent }) {
  return (
    <button className={'sw' + (on ? ' on' : '')} onClick={() => onChange(!on)}
      style={on ? { background: accent || 'var(--accent)' } : null} aria-label="Basculer">
      <span className="sw-knob" />
    </button>
  );
}

function SegRow({ options, value, onChange }) {
  return (
    <div className="seg">
      {options.map((o) => (
        <button key={o.v} className={'seg-btn' + (value === o.v ? ' on' : '')} onClick={() => onChange(o.v)}>{o.l}</button>
      ))}
    </div>
  );
}

/* =========================================================
   RÉCOMPENSES
   ========================================================= */
const REWARDS0 = [
  { id: 'r1', name: 'Sortie ciné en tribu', goal: 100, kind: 'Tribu', color: 'lea' },
  { id: 'r2', name: 'Léa choisit le repas', goal: 40, kind: 'Léa', color: 'lea' },
  { id: 'r3', name: 'Soirée jeux', goal: 70, kind: 'Tribu', color: 'maman' },
  { id: 'r4', name: '1h de jeu bonus', goal: 30, kind: 'Tom', color: 'tom' },
];

function Rewards({ tw, cvars, onBack }) {
  const accent = tw.accent;
  const [rewards, setRewards] = React.useState(REWARDS0);
  const familyPts = 84; // total de la semaine (démo)

  return (
    <div className="app" style={{ ...cvars, '--accent': accent, '--r': tw.radius + 'px' }}>
      <div className="scroll" style={{ paddingBottom: 108 }}>
        <SetHeader title="Récompenses" sub="Des objectifs à débloquer avec les points. Zéro pression, que du fun." onBack={onBack} />

        {/* solde famille */}
        <div className="prog" style={{ marginBottom: 20 }}>
          <div className="row1" style={{ alignItems: 'center' }}>
            <div style={{ flex: 1 }}>
              <div className="big">Cagnotte de la semaine</div>
              <div style={{ display: 'flex', alignItems: 'baseline', gap: 7, marginTop: 2 }}>
                <span className="disp" style={{ fontWeight: 600, fontSize: 34, lineHeight: 1, color: 'color-mix(in oklab, var(--accent) 62%, #1B141F)' }}>{familyPts}</span>
                <span className="disp" style={{ fontWeight: 500, fontSize: 15, color: 'color-mix(in oklab, var(--accent) 55%, #2A2230)' }}>points tribu</span>
              </div>
            </div>
            <div className="set-gift" style={{ background: 'rgba(255,255,255,.6)', color: 'color-mix(in oklab, var(--accent) 70%, #000 6%)' }}>{React.cloneElement(HIcon.gift, { style: { width: 26, height: 26 } })}</div>
          </div>
        </div>

        <div className="dt-label">Objectifs · {rewards.length}</div>
        {rewards.map((r) => {
          const pct = Math.min(1, familyPts / r.goal);
          const reached = familyPts >= r.goal;
          const c = `var(--m-${r.color})`;
          return (
            <div key={r.id} className="rw-card">
              <div className="rw-emoji" style={{ background: 'var(--accent-soft)' }}>{React.cloneElement(HIcon.gift, { style: { width: 22, height: 22 } })}</div>
              <div style={{ flex: 1, minWidth: 0 }}>
                <div className="rw-top">
                  <span className="rw-name">{r.name}</span>
                  <span className="rw-kind" style={{ background: `var(--m-${r.color}-soft)`, color: `color-mix(in oklab, ${c} 74%, #000 8%)` }}>{r.kind}</span>
                </div>
                <div className="rw-bar"><i style={{ width: `${pct * 100}%`, background: c }} /></div>
                <div className="rw-sub">
                  {reached
                    ? <span style={{ color: 'color-mix(in oklab, var(--m-maman) 80%, #000)', fontWeight: 800 }}>{HIcon.check} Débloqué !</span>
                    : <span>{familyPts} / {r.goal} pts · plus que {r.goal - familyPts}</span>}
                </div>
              </div>
            </div>
          );
        })}

        <button className="set-add">{React.cloneElement(HIcon.plus, { style: { width: 18, height: 18 } })}Ajouter une récompense</button>
      </div>

      <div className="dt-action">
        <button className="dt-btn" onClick={onBack} style={{ background: accent, boxShadow: `0 8px 20px color-mix(in oklab, ${accent} 45%, transparent)` }}>{HIcon.check}Terminé</button>
      </div>
    </div>
  );
}

/* =========================================================
   RÉCURRENCES & RAPPELS
   ========================================================= */
function Reminders({ tw, cvars, onBack }) {
  const accent = tw.accent;
  const [remind, setRemind] = React.useState(true);
  const [lead, setLead] = React.useState('30');
  const [morning, setMorning] = React.useState(true);
  const [evening, setEvening] = React.useState(true);
  const [overdue, setOverdue] = React.useState(true);
  const [quiet, setQuiet] = React.useState(true);
  const [resetDay, setResetDay] = React.useState('mon');

  return (
    <div className="app" style={{ ...cvars, '--accent': accent, '--r': tw.radius + 'px' }}>
      <div className="scroll" style={{ paddingBottom: 108 }}>
        <SetHeader title="Récurrences & rappels" sub="Quand et comment l’app rappelle les tâches à la tribu." onBack={onBack} />

        {/* Rappels */}
        <div className="dt-label">Rappels</div>
        <div className="set-card">
          <div className="set-row">
            <span className="set-ic" style={{ background: 'var(--sun-soft)', color: 'var(--sun)' }}>{HIcon.bell}</span>
            <div className="set-txt"><div className="set-l">Rappeler les tâches</div><div className="set-d">Une notif avant l’heure prévue</div></div>
            <Toggle on={remind} onChange={setRemind} accent={accent} />
          </div>
          {remind && (
            <React.Fragment>
              <div className="set-div" />
              <div className="set-block">
                <div className="set-l" style={{ marginBottom: 9 }}>Prévenir avant</div>
                <SegRow value={lead} onChange={setLead} options={[
                  { v: '0', l: 'À l’heure' }, { v: '15', l: '15 min' }, { v: '30', l: '30 min' }, { v: '60', l: '1 h' },
                ]} />
              </div>
            </React.Fragment>
          )}
        </div>

        {/* Récapitulatifs */}
        <div className="dt-label" style={{ marginTop: 20 }}>Récapitulatifs</div>
        <div className="set-card">
          <div className="set-row">
            <span className="set-ic" style={{ background: 'var(--sun-soft)', color: 'var(--sun)' }}>{HIcon.sun}</span>
            <div className="set-txt"><div className="set-l">Résumé du matin</div><div className="set-d">Les tâches du jour à 8:00</div></div>
            <Toggle on={morning} onChange={setMorning} accent={accent} />
          </div>
          <div className="set-div" />
          <div className="set-row">
            <span className="set-ic" style={{ background: 'var(--dusk-soft)', color: 'var(--dusk)' }}>{HIcon.moon}</span>
            <div className="set-txt"><div className="set-l">Rappel du soir</div><div className="set-d">Ce qu’il reste à faire à 19:00</div></div>
            <Toggle on={evening} onChange={setEvening} accent={accent} />
          </div>
          <div className="set-div" />
          <div className="set-row">
            <span className="set-ic" style={{ background: 'var(--m-lea-soft)', color: 'var(--m-lea)' }}>{HIcon.clock}</span>
            <div className="set-txt"><div className="set-l">Tâches en retard</div><div className="set-d">Prévenir si une tâche est oubliée</div></div>
            <Toggle on={overdue} onChange={setOverdue} accent={accent} />
          </div>
        </div>

        {/* Récurrences */}
        <div className="dt-label" style={{ marginTop: 20 }}>Récurrences</div>
        <div className="set-card">
          <div className="set-block">
            <div className="set-l" style={{ marginBottom: 3 }}>Début de semaine</div>
            <div className="set-d" style={{ marginBottom: 9 }}>Jour où les points hebdo repartent à zéro</div>
            <SegRow value={resetDay} onChange={setResetDay} options={[
              { v: 'mon', l: 'Lundi' }, { v: 'sat', l: 'Samedi' }, { v: 'sun', l: 'Dimanche' },
            ]} />
          </div>
          <div className="set-div" />
          <div className="set-row">
            <span className="set-ic" style={{ background: 'var(--m-maman-soft)', color: 'var(--m-maman)' }}>{HIcon.repeat}</span>
            <div className="set-txt"><div className="set-l">Reporter automatiquement</div><div className="set-d">Une tâche non faite passe au lendemain</div></div>
            <Toggle on={quiet} onChange={setQuiet} accent={accent} />
          </div>
        </div>

        <div className="set-note">{React.cloneElement(HIcon.sparkle, { style: { width: 14, height: 14, stroke: accent } })}<span>Chaque tâche peut aussi avoir ses propres rappels, réglés à sa création.</span></div>
      </div>

      <div className="dt-action">
        <button className="dt-btn" onClick={onBack} style={{ background: accent, boxShadow: `0 8px 20px color-mix(in oklab, ${accent} 45%, transparent)` }}>{HIcon.check}Enregistrer</button>
      </div>
    </div>
  );
}

window.Rewards = Rewards;
window.Reminders = Reminders;
