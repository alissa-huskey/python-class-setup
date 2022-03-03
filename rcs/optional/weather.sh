

# weather report from wttr.in
# --------------------------------------------------------------------

if command -v curl > /dev/null; then
  curl "wttr.in?0Fu"
  # curl "wttr.in/moon?Fu"
fi

