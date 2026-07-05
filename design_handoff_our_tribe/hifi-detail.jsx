/* hifi-detail.jsx — Détail d'une tâche */

const MEMBER_NAMES = { lea: 'Léa', papa: 'Papa', maman: 'Maman', tom: 'Tom' };

function TaskDetail({ task, onBack, onToggle, cvars }) {
  const who = task.who || 'lea';
  const whoName = task.whoName || MEMBER_NAMES[who] || 'Léa';
  const isMe = who === 'lea';
  const c = `var(--m-${who})`;
  const timeLabel = task.time ? `Aujourd’hui · ${task.time}` : 'Aujourd’hui';

  return (
    <div className="app" style={cvars}>
      <div className="scroll" style={{ paddingTop: 58 }}>
        {/* top actions */}
        <div className="dt-top">
          <button className="dt-iconbtn" onClick={onBack} aria-label="Retour">{HIcon.chevL}</button>
          <button className="dt-iconbtn dt-edit">{HIcon.pencil}<span>Modifier</span></button>
        </div>

        {/* banner */}
        {task.photo ? (
          <div className="dt-photo" />
        ) : (
          <div className="dt-banner" style={{ background: `var(--m-${who}-soft)`, color: c }}>
            {React.cloneElement(HIcon.sparkle, { style: { width: 34, height: 34 } })}
          </div>
        )}

        {/* title + points */}
        <div className="dt-head">
          <h1 className="dt-title">{task.name}</h1>
          <span className="tpts dt-pts">{HIcon.star}{task.pts}</span>
        </div>

        {/* chips */}
        <div className="dt-chips">
          <span className="dt-chip">{HIcon.clock}{timeLabel}</span>
          {task.rep && <span className="dt-chip">{HIcon.repeat}{task.rep}</span>}
        </div>

        {/* description */}
        <div className="dt-label">Description</div>
        <p className="dt-desc">
          {task.desc || 'Tâche récurrente de la maison. Ajoute des détails ou une photo pour aider la personne qui s’en occupe.'}
        </p>

        {/* assignee */}
        <div className="dt-assignee">
          <div className="dt-ava" style={{ background: `var(--m-${who}-soft)`, color: c, borderColor: `color-mix(in oklab, ${c} 35%, #fff)` }}>{whoName[0]}</div>
          <div style={{ flex: 1, minWidth: 0 }}>
            <div className="dt-ass-l">Attribuée à</div>
            <div className="dt-ass-n">{whoName}{isMe && <span className="lead-you"> · toi</span>}</div>
          </div>
          <span className="dt-change">changer</span>
        </div>

        {/* activity */}
        <div className="dt-label" style={{ marginTop: 20 }}>Activité</div>
        <div className="dt-activity">
          <span className="dt-act-dot" style={{ background: c }}>{HIcon.check}</span>
          <span>Fait la semaine dernière par {whoName} · <b style={{ color: 'color-mix(in oklab, var(--honey-d) 90%, #000)' }}>+{task.pts}</b></span>
        </div>
      </div>

      {/* sticky action */}
      <div className="dt-action">
        <button
          className={'dt-btn' + (task.done ? ' done' : '')}
          style={task.done ? null : { background: c, boxShadow: `0 8px 20px color-mix(in oklab, ${c} 45%, transparent)` }}
          onClick={() => onToggle(task.id)}
        >
          {task.done ? <React.Fragment>{HIcon.check}Fait ! Annuler</React.Fragment>
                     : <React.Fragment>{HIcon.check}Marquer comme fait</React.Fragment>}
        </button>
      </div>
    </div>
  );
}

window.TaskDetail = TaskDetail;
