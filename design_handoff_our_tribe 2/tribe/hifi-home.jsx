/* hifi-home.jsx — Accueil « Mes tâches du jour » (variante A + anneau) */

const HIcon = {
  bell:  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M6 9a6 6 0 1112 0c0 4.5 1.6 5.6 2 6H4c.4-.4 2-1.5 2-6"/><path d="M10.2 20a2 2 0 003.6 0"/></svg>,
  star:  <svg viewBox="0 0 24 24"><path d="M12 2.4 20 7v10l-8 4.6L4 17V7Z" fill="currentColor"/></svg>,
  check: <svg viewBox="0 0 24 24"><path d="M5 12.5l4.5 4.5L19 7"/></svg>,
  clock: <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="12" r="8.4"/><path d="M12 7.6V12l2.8 1.8"/></svg>,
  repeat:<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><path d="M4 9a5 5 0 015-5h6M4 9l2.5-2.5M4 9l2.5 2.5"/><path d="M20 15a5 5 0 01-5 5H9m11-5l-2.5 2.5M20 15l-2.5-2.5"/></svg>,
  sun:   <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M2 12h2M20 12h2M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4"/></svg>,
  cloud: <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><path d="M7 18a4 4 0 01-.5-7.97A5.5 5.5 0 0117.5 11 3.5 3.5 0 0117 18z"/></svg>,
  moon:  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><path d="M20 14.5A7.5 7.5 0 019.5 4a7.5 7.5 0 1010.5 10.5z"/></svg>,
  home:  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><path d="M3.5 11L12 4l8.5 7"/><path d="M5.5 9.5V20h13V9.5"/></svg>,
  cal:   <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><rect x="3.5" y="5" width="17" height="15" rx="3.5"/><path d="M3.5 9.5h17M8 3v3.5M16 3v3.5"/></svg>,
  list:  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><path d="M9 6h11M9 12h11M9 18h11"/><circle cx="4.5" cy="6" r="1.3" fill="currentColor" stroke="none"/><circle cx="4.5" cy="12" r="1.3" fill="currentColor" stroke="none"/><circle cx="4.5" cy="18" r="1.3" fill="currentColor" stroke="none"/></svg>,
  chart: <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><path d="M5 20V10M12 20V4M19 20v-7"/></svg>,
  plus:  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.4" strokeLinecap="round"><path d="M12 5v14M5 12h14"/></svg>,
  gift:  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><rect x="4" y="9" width="16" height="11" rx="2"/><path d="M4 13h16M12 9v11"/><path d="M12 9C9.5 9 8 5 12 5s2.5 4 0 4z"/></svg>,
  chevL: <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.4" strokeLinecap="round" strokeLinejoin="round"><path d="M15 5l-7 7 7 7"/></svg>,
  chevR: <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.4" strokeLinecap="round" strokeLinejoin="round"><path d="M9 5l7 7-7 7"/></svg>,
  up:    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.6" strokeLinecap="round" strokeLinejoin="round"><path d="M12 19V6M6 11l6-6 6 6"/></svg>,
  pencil:<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><path d="M16.5 4.5l3 3L8 19l-4 1 1-4z"/><path d="M14.5 6.5l3 3"/></svg>,
  sparkle:<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M12 3l1.8 5.2L19 10l-5.2 1.8L12 17l-1.8-5.2L5 10l5.2-1.8z"/><path d="M18.5 15.5l.7 2 2 .7-2 .7-.7 2-.7-2-2-.7 2-.7z"/></svg>,
  cam:   <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><path d="M3.5 8.5h3L8 6.2h8l1.5 2.3h3v11h-17z"/><circle cx="12" cy="13.5" r="3.4"/></svg>,
  minus: <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.6" strokeLinecap="round"><path d="M5 12h14"/></svg>,
  close: <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.4" strokeLinecap="round"><path d="M6 6l12 12M18 6L6 18"/></svg>,
  help:  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="12" r="8.5"/><path d="M9.5 9.5a2.5 2.5 0 013.8-2c1.3.8 1 2.4-.3 3-.7.3-1 .8-1 1.6"/><circle cx="12" cy="16.5" r="1" fill="currentColor" stroke="none"/></svg>,
  share: <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><path d="M12 15V4M8.5 7.5L12 4l3.5 3.5"/><path d="M6 12v7a1 1 0 001 1h10a1 1 0 001-1v-7"/></svg>,
  logout:<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><path d="M15 5H6a1 1 0 00-1 1v12a1 1 0 001 1h9"/><path d="M18 12H10m8 0l-3-3m3 3l-3 3"/></svg>,
  user:  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="8" r="3.6"/><path d="M5 19.5a7 7 0 0114 0"/></svg>,
  users: <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.1" strokeLinecap="round" strokeLinejoin="round"><circle cx="9" cy="8" r="3.2"/><path d="M3.5 19a5.5 5.5 0 0111 0"/><path d="M16 5.2a3.2 3.2 0 010 5.8M20.5 19a5.5 5.5 0 00-3.4-5.1"/></svg>,
};

// tween a number toward target
function useCountUp(target, dur = 550) {
  const [v, setV] = React.useState(target);
  const ref = React.useRef(target);
  React.useEffect(() => {
    const from = ref.current, to = target, t0 = performance.now();
    if (from === to) return;
    let raf;
    const tick = (t) => {
      const p = Math.min(1, (t - t0) / dur);
      const e = 1 - Math.pow(1 - p, 3);
      const cur = Math.round(from + (to - from) * e);
      setV(cur); ref.current = cur;
      if (p < 1) raf = requestAnimationFrame(tick);
    };
    raf = requestAnimationFrame(tick);
    return () => cancelAnimationFrame(raf);
  }, [target, dur]);
  return v;
}

const SECTIONS = [
  { key: 'am', title: 'Ce matin',        color: 'sun',  icon: 'sun'   },
  { key: 'pm', title: 'Cet après-midi',  color: 'sky',  icon: 'cloud' },
  { key: 'ev', title: 'Ce soir',         color: 'dusk', icon: 'moon'  },
];

const TASKS0 = [
  { id: 't1', s: 'am', name: 'Vider le lave-vaisselle', time: '8:00',  rep: 'tous les jours', pts: 2, done: true,  who: 'lea',  whoName: 'Léa' },
  { id: 't2', s: 'am', name: 'Donner à manger au chat',  time: '8:30', rep: '2×/jour',        pts: 1, done: true,  who: 'tom',  whoName: 'Tom' },
  { id: 't3', s: 'am', name: 'Préparer le sac de sport', time: '8:45', pts: 1, done: false, who: null },
  { id: 't4', s: 'pm', name: 'Sortir les poubelles',     time: '17:00', rep: '1×/semaine',    pts: 3, done: false, who: 'papa', whoName: 'Papa' },
  { id: 't5', s: 'pm', name: 'Devoirs de maths',         time: '18:00', pts: 2, photo: true, done: false, who: 'lea', whoName: 'Léa' },
  { id: 't6', s: 'ev', name: 'Mettre la table',          time: '19:00', rep: '3×/jour',       pts: 1, done: false, who: null, rotate: true },
  { id: 't7', s: 'ev', name: 'Ranger le salon',          time: '20:00', pts: 2, done: false, who: 'maman', whoName: 'Maman' },
];

function ProgressRing({ pct }) {
  const R = 30, C = 2 * Math.PI * R;
  const off = C * (1 - pct);
  return (
    <div style={{ position: 'relative', width: 78, height: 78, flex: '0 0 auto' }}>
      <svg viewBox="0 0 78 78" style={{ width: 78, height: 78, transform: 'rotate(-90deg)' }}>
        <circle cx="39" cy="39" r={R} fill="none" stroke="rgba(255,255,255,.7)" strokeWidth="8" />
        <circle cx="39" cy="39" r={R} fill="none" strokeWidth="8" strokeLinecap="round"
          strokeDasharray={C} strokeDashoffset={off}
          style={{ stroke: 'var(--accent)', transition: 'stroke-dashoffset .6s cubic-bezier(.34,1.3,.5,1)' }} />
      </svg>
      <div style={{ position: 'absolute', inset: 0, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center' }}>
        <span className="disp" style={{ fontWeight: 600, fontSize: 22, lineHeight: 1, color: 'color-mix(in oklab, var(--accent) 60%, #1B141F)' }}>{Math.round(pct * 100)}<span style={{ fontSize: 12 }}>%</span></span>
      </div>
    </div>
  );
}

function TaskCard({ t, onToggle, onOpen }) {
  const [pop, setPop] = React.useState(false);
  const secColor = SECTIONS.find((s) => s.key === t.s).color;
  const toggle = (e) => {
    e.stopPropagation();
    if (!t.done) { setPop(true); setTimeout(() => setPop(false), 360); }
    onToggle(t.id);
  };
  const style = {
    '--tc': `var(--${secColor})`,
    '--tc-soft': `var(--${secColor}-soft)`,
    '--tc-d': `color-mix(in oklab, var(--${secColor}) 78%, #000 10%)`,
  };
  return (
    <div className={'tcard' + (t.done ? ' done' : '')} style={{ ...style, cursor: 'pointer' }} onClick={() => onOpen && onOpen(t)}>
      <button className={'tick' + (pop ? ' pop' : '')} onClick={toggle} aria-label="Terminer">
        {HIcon.check}
      </button>
      <div className="tbody">
        <div className="tname">{t.name}</div>
        <div className="tmeta">
          <span className="m">{HIcon.clock}{t.time}</span>
          {t.rep && <span className="m rep">{HIcon.repeat}{t.rep}</span>}
          {t.who && <span className="m"><span className="who-dot" style={{ background: `var(--m-${t.who})` }} />{t.whoName}</span>}
          {t.rotate && <span className="m rot-badge">{React.cloneElement(HIcon.repeat, { style: { width: 11, height: 11 } })}À tour de rôle</span>}
        </div>
      </div>
      <div className="tright">
        {t.photo && <div className="tphoto" title="photo" />}
        <span className="tpts">{HIcon.star}{t.pts}</span>
      </div>
    </div>
  );
}

function TabBar({ active, onNav }) {
  const items = [
    { k: 'home', ic: 'home', label: 'Accueil' },
    { k: 'week', ic: 'cal',  label: 'Semaine' },
    { k: 'add',  fab: true },
    { k: 'pts',  ic: 'chart', label: 'Famille' },
    { k: 'profile', ic: 'user', label: 'Profil' },
  ];
  return (
    <nav className="tabs">
      {items.map((it) => it.fab ? (
        <div className="fab" key="add" onClick={() => onNav && onNav('add')}>{HIcon.plus}</div>
      ) : (
        <div key={it.k} className={'tab' + (it.k === active ? ' on' : '')} onClick={() => onNav && onNav(it.k)}>
          {HIcon[it.ic]}<span>{it.label}</span>
        </div>
      ))}
    </nav>
  );
}

function UnassignedCard({ t, members, onAssign, onToggle, onOpen }) {
  const [pick, setPick] = React.useState(false);
  return (
    <div className="ua-card">
      <div className="ua-main" onClick={() => onOpen && onOpen(t)} style={{ cursor: 'pointer' }}>
        <div className="tbody">
          <div className="tname">{t.name}</div>
          <div className="tmeta">
            <span className="m">{HIcon.clock}{t.time}</span>
            {t.rep && <span className="m rep">{HIcon.repeat}{t.rep}</span>}
            {t.rotate && <span className="m rot-badge">{React.cloneElement(HIcon.repeat, { style: { width: 11, height: 11 } })}À tour de rôle</span>}
          </div>
        </div>
        <span className="tpts">{HIcon.star}{t.pts}</span>
      </div>
      <div className="ua-assign">
        <span className="ua-label">{t.rotate ? 'Qui s’en occupe cette fois ?' : 'Attribuer à'}</span>
        <div className="ua-avas">
          {members.map((m) => (
            <button key={m.id} className="ua-ava" style={{ background: `var(--m-${m.color})`, color: '#fff' }}
              onClick={() => onAssign && onAssign(t.id, m.id)} aria-label={m.name} title={m.name}>{m.initial}</button>
          ))}
        </div>
      </div>
    </div>
  );
}

function Home({ tw, onNav, tasks, onToggle, onOpen, onProfile, cvars, members, onAssign, onOpenUnassigned }) {
  const [confetti, setConfetti] = React.useState(false);
  const prevAllDone = React.useRef(false);

  const total = tasks.length;
  const doneCount = tasks.filter((t) => t.done).length;
  const ptsToday = tasks.filter((t) => t.done).reduce((a, t) => a + t.pts, 0);
  const pct = total ? doneCount / total : 0;
  const allDone = doneCount === total;

  React.useEffect(() => {
    if (allDone && !prevAllDone.current) { setConfetti(true); setTimeout(() => setConfetti(false), 1200); }
    prevAllDone.current = allDone;
  }, [allDone]);

  const animPts = useCountUp(ptsToday);
  const animDone = useCountUp(doneCount, 400);

  let msg = 'En route, on y va';
  if (allDone) msg = 'Tout est fait — la tribu assure';
  else if (doneCount === 0) msg = 'En route, on y va';
  else if (total - doneCount <= 2) msg = `Plus que ${total - doneCount}, tu gères`;
  else msg = 'Belle lancée, continue';

  const accentVar = { '--accent': tw.accent };

  return (
    <div className="app" style={{ ...cvars, ...accentVar, '--r': tw.radius + 'px' }}>
      <div className="scroll">
        {/* header */}
        <div className="hdr">
          <div>
            <div className="brand"><span className="brand-mark">OT</span>Our Tribe</div>
            <div className="hi">Salut la tribu</div>
          </div>
          <div className="hdr-right">
            <div className="pts-pill">{HIcon.star}<span style={{ display: 'inline-block', minWidth: 16, textAlign: 'right' }}>{animPts}</span></div>
          </div>
        </div>

        {/* progress card with ring */}
        {tw.showProgress && (
          <div className="prog">
            <div className="row1">
              <div style={{ flex: 1, minWidth: 0 }}>
                <div className="big">{animDone} sur {total} tâches faites</div>
                <div className="msg">{msg}</div>
              </div>
              <div className="today">
                <div className="n">+{animPts}</div>
                <div className="l">points</div>
              </div>
            </div>
            <div className="bar"><i style={{ width: `${Math.round(pct * 100)}%` }} /></div>
          </div>
        )}

        {/* sections */}
        {/* À répartir — bandeau vers la vue dédiée */}
        {(() => {
          const n = tasks.filter((t) => !t.who && !t.done).length;
          if (!n) return null;
          return (
            <button className="ua-banner" onClick={onOpenUnassigned}>
              <span className="ua-banner-ic">{React.cloneElement(HIcon.users, { style: { width: 20, height: 20 } })}</span>
              <span className="ua-banner-txt">
                <span className="ua-banner-t">{n} tâche{n > 1 ? 's' : ''} à répartir</span>
                <span className="ua-banner-d">Personne n’est encore assigné · appuie pour répartir</span>
              </span>
              <span className="ua-banner-n">{n}</span>
              {React.cloneElement(HIcon.chevR, { style: { width: 18, height: 18, stroke: 'var(--ochre)' } })}
            </button>
          );
        })()}

        {SECTIONS.map((sec) => {
          const items = tasks.filter((t) => t.s === sec.key && (t.who || t.done));
          if (!items.length) return null;
          const d = items.filter((t) => t.done).length;
          return (
            <div className="sec" key={sec.key}>
              <div className="sec-hd">
                <div className="sec-ic" style={{ background: `var(--${sec.color}-soft)`, color: `var(--${sec.color})` }}>{HIcon[sec.icon]}</div>
                <div className="sec-ttl">{sec.title}</div>
                <div className="sec-count">{d}/{items.length}</div>
              </div>
              {items.map((t) => <TaskCard key={t.id} t={t} onToggle={onToggle} onOpen={onOpen} />)}
            </div>
          );
        })}
      </div>

      {/* tab bar */}
      <TabBar active="home" onNav={onNav} />

      {confetti && (
        <div className="confetti">
          {Array.from({ length: 16 }).map((_, i) => {
            const ang = (i / 16) * Math.PI * 2;
            const dist = 90 + (i % 3) * 34;
            const cols = ['#2F6D4E', '#B4654A', '#4F6D97', '#9C7C43', '#6E6396'];
            return <i key={i} style={{
              left: '50%',
              background: cols[i % cols.length],
              '--dx': Math.cos(ang) * dist + 'px',
              '--dy': Math.sin(ang) * dist - 30 + 'px',
              '--rot': (i * 47) + 'deg',
              animationDelay: (i % 4) * 20 + 'ms',
            }} />;
          })}
        </div>
      )}
    </div>
  );
}

// build CSS custom-prop overrides for member colors (soft derived via color-mix)
function buildColorVars(mc) {
  const o = {};
  Object.keys(mc).forEach((k) => {
    o['--m-' + k] = mc[k];
    o['--m-' + k + '-soft'] = `color-mix(in oklab, ${mc[k]} 20%, #fff)`;
  });
  return o;
}

function Unassigned({ tw, cvars, tasks, members, onAssign, onOpen, onBack }) {
  const list = tasks.filter((t) => !t.who && !t.done);
  return (
    <div className="app" style={{ ...cvars, '--accent': tw.accent, '--r': tw.radius + 'px' }}>
      <div className="scroll" style={{ paddingTop: 56, paddingBottom: 40 }}>
        <button className="ob-back" onClick={onBack} aria-label="Retour">{HIcon.chevL}</button>
        <h1 className="ob-title">À répartir</h1>
        <p className="ob-sub">Ces tâches n’ont pas encore de responsable. Choisis qui s’en occupe.</p>
        {list.length === 0 ? (
          <div className="ua-empty">
            <span className="ua-empty-ic">{React.cloneElement(HIcon.check, { style: { width: 26, height: 26, stroke: 'var(--accent)', strokeWidth: 2.4, fill: 'none' } })}</span>
            <div className="ua-empty-t">Tout est réparti</div>
            <div className="ua-empty-d">Chaque tâche a son responsable.</div>
          </div>
        ) : list.map((t) => (
          <UnassignedCard key={t.id} t={t} members={members || []} onAssign={onAssign} onOpen={onOpen} />
        ))}
      </div>
    </div>
  );
}

window.Unassigned = Unassigned;
window.Home = Home;
Object.assign(window, { HIcon, TabBar, useCountUp, TASKS0, SECTIONS, buildColorVars });
