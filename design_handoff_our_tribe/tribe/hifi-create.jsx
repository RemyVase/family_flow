/* hifi-create.jsx — Créer une tâche (formulaire A, complet) */

const CF_MEMBERS = [
  { id: 'lea',   name: 'Moi',   initial: 'L' },
  { id: 'papa',  name: 'Papa',  initial: 'P' },
  { id: 'maman', name: 'Maman', initial: 'M' },
  { id: 'tom',   name: 'Tom',   initial: 'T' },
];

const CF_REP = [
  { id: 'once',   label: 'Une fois',     rep: null },
  { id: 'daily',  label: 'Tous les jours', rep: 'tous les jours' },
  { id: 'weekly', label: '1×/semaine',   rep: '1×/semaine' },
  { id: 'thrice', label: '3×/jour',      rep: '3×/jour' },
];

const CF_MOMENT = [
  { id: 'am', label: 'Matin',       time: '8:00' },
  { id: 'pm', label: 'Après-midi',  time: '17:00' },
  { id: 'ev', label: 'Soir',        time: '19:00' },
];

function CreateTask({ tw, onClose, onCreate, cvars }) {
  const [name, setName] = React.useState('');
  const [desc, setDesc] = React.useState('');
  const [who, setWho] = React.useState('lea');
  const [pts, setPts] = React.useState(2);
  const [rep, setRep] = React.useState('once');
  const [moment, setMoment] = React.useState('ev');

  const canCreate = name.trim().length > 0;
  const accent = tw.accent;

  const submit = () => {
    if (!canCreate) return;
    const m = CF_MOMENT.find((x) => x.id === moment);
    const r = CF_REP.find((x) => x.id === rep);
    const whoObj = CF_MEMBERS.find((x) => x.id === who);
    onCreate({
      id: 'n' + Date.now(),
      s: moment, time: m.time,
      name: name.trim(),
      desc: desc.trim() || undefined,
      rep: r.rep || undefined,
      pts, done: false,
      who, whoName: who === 'lea' ? 'Léa' : whoObj.name,
    });
  };

  return (
    <div className="app" style={{ ...cvars, '--accent': accent, '--r': tw.radius + 'px' }}>
      <div className="scroll" style={{ paddingTop: 56, paddingBottom: 100 }}>
        {/* header */}
        <div className="cf-top">
          <button className="cf-cancel" onClick={onClose}>Annuler</button>
          <div className="cf-title">Nouvelle tâche</div>
          <div style={{ width: 56 }} />
        </div>

        {/* nom */}
        <div className="cf-group">
          <label className="cf-label">Nom de la tâche</label>
          <input className="cf-input" value={name} onChange={(e) => setName(e.target.value)}
            placeholder="Ex. Sortir les poubelles" autoFocus />
        </div>

        {/* description */}
        <div className="cf-group">
          <label className="cf-label">Description <span className="cf-opt">optionnel</span></label>
          <textarea className="cf-input cf-area" value={desc} onChange={(e) => setDesc(e.target.value)}
            placeholder="Ajoute des précisions…" rows={2} />
        </div>

        {/* pour qui */}
        <div className="cf-group">
          <label className="cf-label">Pour qui</label>
          <div className="cf-people">
            {CF_MEMBERS.map((m) => {
              const on = who === m.id;
              return (
                <button key={m.id} className={'cf-person' + (on ? ' on' : '')} onClick={() => setWho(m.id)}
                  style={on ? { borderColor: `var(--m-${m.id})`, background: `var(--m-${m.id}-soft)` } : null}>
                  <span className="cf-ava" style={{ background: `var(--m-${m.id}-soft)`, color: `var(--m-${m.id})`, borderColor: `color-mix(in oklab, var(--m-${m.id}) 35%, #fff)` }}>{m.initial}</span>
                  <span className="cf-person-n" style={on ? { color: `color-mix(in oklab, var(--m-${m.id}) 74%, #000 8%)` } : null}>{m.name}</span>
                </button>
              );
            })}
          </div>
        </div>

        {/* points */}
        <div className="cf-group">
          <label className="cf-label">Points</label>
          <div className="cf-stepper">
            <button className="cf-step" onClick={() => setPts((p) => Math.max(1, p - 1))} disabled={pts <= 1}>{HIcon.minus}</button>
            <span className="cf-pts">{HIcon.star}{pts}</span>
            <button className="cf-step" onClick={() => setPts((p) => Math.min(9, p + 1))} style={{ color: accent }}>{HIcon.plus}</button>
            <span className="cf-hint">Récompense en points</span>
          </div>
        </div>

        {/* récurrence */}
        <div className="cf-group">
          <label className="cf-label">Récurrence</label>
          <div className="cf-chips">
            {CF_REP.map((r) => {
              const on = rep === r.id;
              return (
                <button key={r.id} className={'cf-chip' + (on ? ' on' : '')} onClick={() => setRep(r.id)}
                  style={on ? { borderColor: accent, background: `color-mix(in oklab, ${accent} 14%, #fff)`, color: `color-mix(in oklab, ${accent} 72%, #000 8%)` } : null}>
                  {r.id !== 'once' && React.cloneElement(HIcon.repeat, { style: { width: 13, height: 13 } })}
                  {r.label}
                </button>
              );
            })}
          </div>
        </div>

        {/* quand */}
        <div className="cf-group">
          <label className="cf-label">Quand</label>
          <div className="cf-chips">
            {CF_MOMENT.map((m) => {
              const on = moment === m.id;
              return (
                <button key={m.id} className={'cf-chip' + (on ? ' on' : '')} onClick={() => setMoment(m.id)}
                  style={on ? { borderColor: accent, background: `color-mix(in oklab, ${accent} 14%, #fff)`, color: `color-mix(in oklab, ${accent} 72%, #000 8%)` } : null}>
                  {m.label} · {m.time}
                </button>
              );
            })}
          </div>
        </div>

        {/* photos */}
        <div className="cf-group">
          <label className="cf-label">Photos <span className="cf-opt">optionnel</span></label>
          <div className="cf-photos">
            <button className="cf-addphoto">{HIcon.cam}<span>Ajouter</span></button>
            <div className="cf-photo-ph" />
          </div>
        </div>
      </div>

      {/* sticky create */}
      <div className="dt-action">
        <button className="dt-btn" disabled={!canCreate}
          style={canCreate ? { background: accent, boxShadow: `0 8px 20px color-mix(in oklab, ${accent} 45%, transparent)` } : { background: 'var(--line)', color: 'var(--ink-3)', boxShadow: 'none' }}
          onClick={submit}>
          {React.cloneElement(HIcon.plus, { style: { width: 20, height: 20 } })}Créer la tâche
        </button>
      </div>
    </div>
  );
}

window.CreateTask = CreateTask;
