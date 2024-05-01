export default function() {
  if (!document.querySelector('meta[name=csrf-token]')) { return null; }

  return document.querySelector('meta[name=csrf-token]').getAttribute('content')
}
