/* hifi-tasks.jsx — Liste des tâches de la famille (corps réutilisable) */
/* Rendu à l'intérieur de l'onglet Famille (pas d'app/tabbar propre). */

function FamilyTaskList({ tasks, onToggle, onOpen, accent }) {
  const [filter, setFilter] = React.useState('all');

  const counts = {
    all: tasks.length,
    todo: tasks.filter((t) => !t.done).length,
    done: tasks.filter((t) => t.done).length,
    rec: tasks.filter((t) => t.rep).length,
  };
  const FILTERS = [
    { id: 'all',  label: 'Toutes',      n: counts.all },
    { id: 'todo', label: 'À faire',     n: counts.todo },
    { id: 'done', label: 'Faites',      n: counts.done },
    { id: 'rec',  label: 'Récurrentes', n: counts.rec },
  ];

  const match = (t) => filter === 'all' ? true
    : filter === 'todo' ? !t.done
    : filter === 'done' ? t.done
    : !!t.rep;
  const list = tasks.filter(match);
  const todo = list.filter((t) => !t.done);
  const done = list.filter((t) => t.done);

  const Group = ({ title, items }) => items.length === 0 ? null : (
    <div className="sec">
      <div className="tk-grouphd"><span>{title}</span><span className="sec-count">{items.length}</span></div>
      {items.map((t) => <WeekCard key={t.id} t={t} onToggle={onToggle} onOpen={onOpen} />)}
    </div>
  );

  return (
    <React.Fragment>
      <div className="fl-chips">
        {FILTERS.map((f) => {
          const on = filter === f.id;
          return (
            <button key={f.id} className={'fl-chip' + (on ? ' on' : '')} onClick={() => setFilter(f.id)}
              style={on ? { borderColor: accent, background: accent, color: '#fff' } : null}>
              {f.label}<span className="fl-n" style={on ? { background: 'rgba(255,255,255,.28)', color: '#fff' } : null}>{f.n}</span>
            </button>
          );
        })}
      </div>

      {filter === 'all' ? (
        <React.Fragment>
          <Group title="À faire" items={todo} />
          <Group title="Faites" items={done} />
        </React.Fragment>
      ) : list.length === 0 ? (
        <div className="tk-empty">
          {React.cloneElement(HIcon.sparkle, { style: { width: 30, height: 30, stroke: 'var(--ink-3)' } })}
          <span>Rien ici pour l’instant</span>
        </div>
      ) : (
        <div className="sec">
          {list.map((t) => <WeekCard key={t.id} t={t} onToggle={onToggle} onOpen={onOpen} />)}
        </div>
      )}
    </React.Fragment>
  );
}

window.FamilyTaskList = FamilyTaskList;
