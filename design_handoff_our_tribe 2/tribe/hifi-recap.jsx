/* hifi-recap.jsx — Récap points de la semaine (couleurs par membre) */

const MEMBERS = [
  { id: 'lea',   name: 'Léa',   short: 'Moi', color: 'lea',   initial: 'L', pts: 26, done: 11, medal: '' },
  { id: 'maman', name: 'Maman', color: 'maman', initial: 'M', pts: 22, done: 9,  medal: '' },
  { id: 'papa',  name: 'Papa',  color: 'papa',  initial: 'P', pts: 18, done: 8,  medal: '' },
  { id: 'tom',   name: 'Tom',   color: 'tom',   initial: 'T', pts: 18, done: 8,  medal: '' },
];

function RecapBars({ ranked, max }) {
  return (
    <div style={{ display: 'flex', alignItems: 'flex-end', justifyContent: 'space-around', gap: 10, height: 158, paddingTop: 4 }}>
      {ranked.map((m) => {
        const h = Math.round((m.pts / max) * 82) + 8;
        return (
          <div key={m.id} style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 7, flex: 1 }}>
            <span className="disp" style={{ fontWeight: 600, fontSize: 15, color: `var(--m-${m.color})` }}>{m.pts}</span>
            <div style={{
              width: '76%', maxWidth: 40, height: h, borderRadius: '8px 8px 5px 5px',
              background: `var(--m-${m.color})`,
              boxShadow: 'none',
              transition: 'height .6s cubic-bezier(.34,1.3,.5,1)',
            }} />
            <div style={{
              width: 30, height: 30, borderRadius: '50%', display: 'flex', alignItems: 'center', justifyContent: 'center',
              background: `var(--m-${m.color}-soft)`, color: `var(--m-${m.color})`,
              fontFamily: 'Figtree, system-ui', fontWeight: 600, fontSize: 15,
              border: `1.5px solid color-mix(in oklab, var(--m-${m.color}) 30%, #fff)`,
            }}>{m.initial}</div>
          </div>
        );
      })}
    </div>
  );
}

function Recap({ tw, onNav, tasks, onToggle, onOpen, cvars, members }) {
  const [subtab, setSubtab] = React.useState('summary');
  const activeIds = members ? members.map((m) => m.id) : null;
  const LIST = activeIds ? MEMBERS.filter((m) => activeIds.includes(m.id)) : MEMBERS;
  const ranked = [...LIST].sort((a, b) => b.pts - a.pts);
  const total = LIST.reduce((a, m) => a + m.pts, 0);
  const max = Math.max(...LIST.map((m) => m.pts));
  const goal = 100;
  const rewardPct = Math.min(1, total / goal);
  const animTotal = useCountUp(total);

  return (
    <div className="app" style={{ ...cvars, '--accent': tw.accent, '--r': tw.radius + 'px' }}>
      <div className="scroll">
        {/* header with week switcher */}
        <div className="hdr">
          <div>
            <div className="date">3 – 9 juin</div>
            <div className="hi">La tribu Dubois</div>
          </div>
          <div className="wk">
            <div className="wk-btn">{HIcon.chevL}</div>
            <span>Sem. 24</span>
            <div className="wk-btn dim">{HIcon.chevR}</div>
          </div>
        </div>

        {/* sub-tabs: résumé / tâches */}
        <div className="seg">
          <button className={'seg-btn' + (subtab === 'summary' ? ' on' : '')} onClick={() => setSubtab('summary')}
            style={subtab === 'summary' ? { color: `color-mix(in oklab, ${tw.accent} 72%, #000 6%)` } : null}>Résumé</button>
          <button className={'seg-btn' + (subtab === 'tasks' ? ' on' : '')} onClick={() => setSubtab('tasks')}
            style={subtab === 'tasks' ? { color: `color-mix(in oklab, ${tw.accent} 72%, #000 6%)` } : null}>Tâches</button>
          <span className="seg-thumb" style={{ transform: `translateX(${subtab === 'tasks' ? '100%' : '0'})` }} />
        </div>

        {subtab === 'tasks' ? (
          <FamilyTaskList tasks={tasks} onToggle={onToggle} onOpen={onOpen} accent={tw.accent} />
        ) : (
        <React.Fragment>
        {/* family total */}
        <div className="prog" style={{ marginBottom: 18 }}>
          <div className="row1" style={{ alignItems: 'center' }}>
            <div style={{ flex: 1 }}>
              <div className="big">Total de la tribu</div>
              <div style={{ display: 'flex', alignItems: 'baseline', gap: 8, marginTop: 2 }}>
                <span className="disp" style={{ fontWeight: 600, fontSize: 40, lineHeight: 1, color: 'color-mix(in oklab, var(--accent) 62%, #1B141F)' }}>{animTotal}</span>
                <span className="disp" style={{ fontWeight: 500, fontSize: 16, color: 'color-mix(in oklab, var(--accent) 55%, #2A2230)' }}>points</span>
              </div>
            </div>
            <div className="today" style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 2 }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 2, color: '#2E9E6E' }}>
                {React.cloneElement(HIcon.up, { style: { width: 15, height: 15 } })}
                <span className="disp" style={{ fontWeight: 600, fontSize: 20 }}>12</span>
              </div>
              <div className="l">vs sem. passée</div>
            </div>
          </div>
        </div>

        {/* per-member bars */}
        <div className="panel">
          <div className="panel-hd">Cette semaine, par personne</div>
          <RecapBars ranked={LIST} max={max} />
        </div>

        {/* leaderboard */}
        <div className="lead-hd">
          <span>Le clan cette semaine</span>
          <span className="lead-note">juste pour le fun</span>
        </div>
        {ranked.map((m, i) => (
          <div key={m.id} className="lead-row" style={{
            background: m.id === 'lea' ? `var(--m-${m.color}-soft)` : 'var(--surface)',
            borderColor: m.id === 'lea' ? `color-mix(in oklab, var(--m-${m.color}) 35%, #fff)` : 'var(--line)',
          }}>
            <span className="lead-rank">{m.medal || `${i + 1}`}</span>
            <div className="lead-ava" style={{ background: `var(--m-${m.color})`, color: '#fff', borderColor: `var(--m-${m.color})` }}>{m.initial}</div>
            <div style={{ flex: 1, minWidth: 0 }}>
              <div className="lead-name">{m.name}{m.id === 'lea' && <span className="lead-you"> · toi</span>}</div>
              <div className="lead-sub">{m.done} tâches faites</div>
            </div>
            <span className="lead-pts" style={{ color: `color-mix(in oklab, var(--m-${m.color}) 74%, #000 8%)`, background: `var(--m-${m.color}-soft)` }}>
              {HIcon.star}{m.pts}
            </span>
          </div>
        ))}

        {/* reward */}
        <div className="reward">
          <div className="reward-ic">{HIcon.gift}</div>
          <div style={{ flex: 1, minWidth: 0 }}>
            <div className="reward-ttl">Objectif tribu · sortie ciné</div>
            <div className="reward-bar"><i style={{ width: `${rewardPct * 100}%` }} /></div>
            <div className="reward-sub">{total} / {goal} pts — plus que {Math.max(0, goal - total)} !</div>
          </div>
        </div>
        </React.Fragment>
        )}
      </div>

      <TabBar active="pts" onNav={onNav} />
    </div>
  );
}

window.Recap = Recap;
