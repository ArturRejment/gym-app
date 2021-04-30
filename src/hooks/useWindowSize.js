import { useState, useEffect } from "react";

function getWindowSize() {
  const { innerWidth: width, innerHeight: height } = window;
  return {
    width,
    height,
  };
}

export default function useWindowSize() {
  const [windowSize, setWindowSize] = useState(getWindowSize());

  useEffect(() => {
    let isMounted = true;
    function handleResize() {
      if (isMounted) setWindowSize(getWindowSize());
    }

    window.addEventListener("resize", handleResize);
    return () => {
      isMounted = false;
    };
  }, []);

  return windowSize;
}
