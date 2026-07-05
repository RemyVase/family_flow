/* hifi-week.jsx — Vue semaine (variante B : jour + bande de jours) */

const WK_DAYS = [
  { d: 'L', n: 8,  count: 2 },
  { d: 'M', n: 9,  count: 6, today: true },
  { d: 'M', n: 10, count: 3 },
  { d: 'J', n: 11, count: 4 },
  { d: 'V', n: 12, count: 2 },
  { d: 'S', n: 13, count: 1 },
  { d: 'D', n: 14, count: 0 },
];

// tasks for the selected day (Mardi 9) — family-wide, colored by member
const WK_TASKS = [
  { id: 'w1', time: '8:00',  name: 'Vider le lave-vaisselle', who: 'lea',   whoName: 'Léa',   rep: 'tous les jours', pts: 2, done: true },
  { id: 'w2', time: '8:30',  name: 'Nourrir le chat',         who: 'tom',   whoName: 'Tom',   rep: '2×/jour',        pts: 1, done: true },
  { id: 'w3', time: '15:00', name: 'Lessive',                 who: 'maman', whoName: 'Maman', pts: 2, done: false },
  { id: 'w4', time: '17:00', name: 'Sortir les poubelles',    who: 'papa',  whoName: 'Papa',  rep: '1×/semaine', pts: 3, done: false },
  { id: 'w5', time: '18:00', name: 'Devoirs de maths',        who: 'lea',   whoName: 'Léa',   pts: 2, done: false },
  { id: 'w6', time: '19:00', name: 'Mettre la table',         who: 'tom',   whoName: 'Tom',   rep: '3×/jour', pts: 1, done: false },
  { id: 'w7', time: '20:00', name: 'Ranger le salon',         who: 'maman', whoName: 'Maman', pts: 2, done: false },
];

const NOW_AFTER = 'w2'; // "maintenant" line sits after this task

function WeekCard({ t, onToggle, onOpen }) {
  const [pop, setPop] = React.useState(false);
  const toggle = (e) => { e.stopPropagation(); if (!t.done) { setPop(true); setTimeout(() => setPop(false), 360); } onToggle(t.id); };
  const style = {
    '--tc': `var(--m-${t.who})`,
    '--tc-soft': `var(--m-${t.who}-soft)`,
    '--tc-d': `color-mix(in oklab, var(--m-${t.who}) 76%, #000 10%)`,
    borderLeft: `4px solid var(--m-${t.who})`,
    cursor: 'pointer',
  };
  return (
    <div className={'tcard' + (t.done ? ' done' : '')} style={style} onClick={() => onOpen && onOpen(t)}>
      <button className={'tick' + (pop ? ' pop' : '')} onClick={toggle} aria-label="Terminer">{HIcon.check}</button>
      <div className="tbody">
        <div className="tname">{t.name}</div>
        <div className="tmeta">
          <span className="m" style={{ color: `color-mix(in oklab, var(--m-${t.who}) 74%, #000 8%)` }}>
            <span className="who-dot" style={{ background: `var(--m-${t.who})` }} />{t.whoName}
          </span>
          {t.rep && <span className="m rep">{HIcon.repeat}{t.rep}</span>}
        </div>
      </div>
      <span className="tpts">{HIcon.star}{t.pts}</span>
    </div>
  );
}

function Week({ tw, onNav, tasks, onToggle, onOpen, cvars }) {
  const doneCount = tasks.filter((t) => t.done).length;
  const dayPts = tasks.reduce((a, t) => a + t.pts, 0);

  return (
    <div className="app" style={{ ...cvars, '--accent': tw.accent, '--r': tw.radius + 'px' }}>
      <div className="scroll">
        <div className="hdr">
          <div>
            <div className="date">Semaine 24 · juin</div>
            <div className="hi">Mardi 9</div>
          </div>
          <div className="hdr-right">
            <div className="iconbtn">{HIcon.cal}</div>
          </div>
        </div>

        {/* day strip */}
        <div className="daystrip">
          {WK_DAYS.map((day) => (
            <div key={day.n} className={'day' + (day.today ? ' on' : '')}>
              <span className="day-d">{day.d}</span>
              <span className="day-num">{day.n}</span>
              <span className="day-dots">
                {day.count > 0
                  ? Array.from({ length: Math.min(day.count, 3) }).map((_, i) => <i key={i} />)
                  : <i style={{ visibility: 'hidden' }} />}
              </span>
            </div>
          ))}
        </div>

        <div className="day-summary">
          <span>{tasks.length} tâches · {doneCount} faites</span>
          <span className="tpts" style={{ padding: '3px 9px 3px 7px' }}>{HIcon.star}{dayPts} pts</span>
        </div>

        {/* timeline */}
        <div className="tl">
          {tasks.map((t) => (
            <React.Fragment key={t.id}>
              <div className="tl-row">
                <div className="tl-time">{t.time}</div>
                <div className="tl-rail"><span className="tl-dot" style={{ borderColor: `var(--m-${t.who})` }} /></div>
                <div className="tl-body"><WeekCard t={t} onToggle={onToggle} onOpen={onOpen} /></div>
              </div>
              {t.id === NOW_AFTER && (
                <div className="tl-row now">
                  <div className="tl-time now-t">14:02</div>
                  <div className="tl-rail"><span className="now-dot" /></div>
                  <div className="tl-body"><div className="now-line"><span>maintenant</span></div></div>
                </div>
              )}
            </React.Fragment>
          ))}
        </div>
      </div>

      <TabBar active="week" onNav={onNav} />
    </div>
  );
}

window.Week = Week;
Object.assign(window, { WK_TASKS, WeekCard });
