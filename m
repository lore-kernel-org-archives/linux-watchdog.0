Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D005C38E5DC
	for <linux-watchdog@vger.kernel.org>; Sun, 24 May 2026 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779626516; cv=pass; b=jSvCyi3kWXVtlI95F+SAdA6uMc0cG46WuG3qLAtoUq2dnW6mZPXeO/0ZUhXRi0rGth7Pdx5sCMKX3HZiUgnfkv2ROqDmlkZOmdbXPjsE1H3H6H1EuygczM5ipTNF8+3sz/hSFPR3RwPVgQ9AabglT/SGW25J8QlsyIbc/gJdmBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779626516; c=relaxed/simple;
	bh=iQixGRhxQ2lYAvO6Xt4gzUgMA1dwIbosfsR1NWo0s5w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GMAzWZSyVOcuIr7+YiJ1VuYySmXnFkBsvwmyMnOCM3U0T+sdaY7/YTrGPGVXOJvHeZ2W9+8RWuNySEbGbPfAgBspkKymeeejBQPt1/D+09Scc7KbByTHx9nDeIxFxIxVZ+8cTKWaiVMutLee5timcMHvK4KaCW6LIovbsuI/2Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7L0ffZc; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7L0ffZc"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38eab6cf7d8so63392561fa.1
        for <linux-watchdog@vger.kernel.org>; Sun, 24 May 2026 05:41:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779626513; cv=none;
        d=google.com; s=arc-20240605;
        b=NenLKBVARKh4nvtvc0kpQ5QQ7kyj5nTX4OrmaCOMyz4RGIyBgA+uDknypJludxc2ih
         7Lf5Jxm20DMtbTiD75MdotYnUpkw9Uq9BESx4Gs5KtZxmq9CxMPkM0JdD+AikaKCBbcG
         jf36r/fSnzVCmJAwD9+4pzUsadf44mGBYy0Hc3sRV7aav6c18waLxDfqwyH8izeRRTXM
         PI1wOSwrtdOcLNSQp7bS3yGtTlD4wJHXX7VIXFFPXj3g437SuD/PrtatpzN0TAD9GyUf
         sLB2Zp95i5T4mJV0de6xid3WzNmO4zUTGDuS+NtgQkAWI35LzdmxtTwJKUk8Uy0lZ4vh
         7kMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=4/98YHBiUvLfMPS6LITOOPMQcJ+H5TqK7sLdZGcIrM4=;
        fh=6GFrMM5/B/Ynh2Ke81Gcd2nIeM5xxYzZuGFDDArMzgo=;
        b=Erz9PRxuVpyp2hsRI0V0hQsKCiW6twtq9kNpRYWw5QHIct/rFeK3RWHYf1AJDuuNz/
         GoyIg5DGXCbU7mV9xJLWbdMsxrFnVB+Iyb4wxPn7ScqR82zgetusP6ftdWnpRtXwz1tB
         uciPaAlsWwcvs6c3+ES37qdmCZfKqlIRwQot7xdrB2X921Rf1vv3FJcSi1i4FCCf0lde
         2XACAgJizRMLFc3/dHDLK6yp/QmQDqm9SpSB2MCbgTVMFtbkmEL7vlVxnSFHZa7vaOPz
         5KDcwlO34gZlwKq5Xay3+GJvgBbMCM3MbqykCRMTtwPbxdkD0cg69nETzj1KMAAKFRWV
         u6Jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779626513; x=1780231313; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4/98YHBiUvLfMPS6LITOOPMQcJ+H5TqK7sLdZGcIrM4=;
        b=g7L0ffZcZTwqDsL4nPT6ZkJtfhZA+VwVJEDdmU2qk7V0S6J1oa3B+IE0bMAeOwNaXZ
         jT1YzJGuw6mo/ac2LQ67zSgpHKfL90LwT7aUNwJkQjT+E5/snjWM45Rt6l4f7HUQrgFd
         Or0/3QSxFspz92pfE9+FzPK7OE2+f9hYJ0bn7ujEdvElX+ZHuPcCaRASO27NmU1lRYNi
         f4iCP5J5d2AAHKeqxKzY2I4B0SJNDkvWrCoSkodvnKWo05fUhsEUZF+w1fjcPFgEF9j+
         NPpOBQrjJUd8IUpvP6cMCvl59bPBZutflQtSjORub0pIAuKnixzdmsF67BGxQIiMqXXF
         5NTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779626513; x=1780231313;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4/98YHBiUvLfMPS6LITOOPMQcJ+H5TqK7sLdZGcIrM4=;
        b=fWph5QefHBbd89kTGrKxxWNCly/4/nGccJRr+rQgKBNXDLDXW1OonOTW4bjcu4N+RX
         +v/DMBBBei1PNDSY5TR/7KhYzEMD7NJ65GqEHW/sIAePvp7Qn75DjqRiSpI3TmbFV0ym
         9K5yie2ClgHTrW+D2N8lHoXWN7YQzvYoRFCfZEw0GZQxg2Y7Pn9ty6MFsKPNWnSfs3/y
         cACnLXVRfNLPTJeXhdrsrr8z7Vf4NKTqVZm5T6CkxdkSzNzTBOUaDZfv1KVZ3W7UMvf/
         R+kb3ZAhOxiyBgSKVn5qIA1fMRlrG6i2ovH0PDylR671RNlpnOyoBeg9uIBpO/LFQ/Qs
         /hRA==
X-Forwarded-Encrypted: i=1; AFNElJ/4Uvm9HewRtm6UL9ycA2JitxYuywnoD4RW1cE7toxHJp+mBuksXdvY7p/wKpaSnJs405AKST3EaaYd/Zsirw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDMJ4FYYvzMi9jEO/q8UZ/FZtZssPo+wOgz3KOjpGDeICp9KND
	nwcv7yrZ/9PJEHhi4+S1ORAUbDv1ByXRmgQl4e4bzMbOEY4HBR2iTKubWXQao5BboIm/Qv0H1DU
	GxSOi1UuzSgDpsNSWQwvkSQPZVNYtKA5WQQ==
X-Gm-Gg: Acq92OF5gCjs2dcVtCNTRc7WWfrFRcmnVdVZAv1kNw/ei3efEw7hGe5uWWH7UHywUFz
	ngTB70XQ6d/tDoctgutDqqohcCr6MhXnTvJf9he6fPTpjNXE9X3a35Cn2TM0muRF0tMY00SSHwK
	tyPg5D91abTJ1zARstHwgscXcGM5fMP+DitUGNue4NoUV00Rq/OaDF7JA9UlvvekBza9yH1WoQI
	uGsCPO4YKVv9vRB/zsPJDoDool/ZKvJrdf/ePETbJw54r1kW1lCEjLOwxLr9LA8JIbMqZOuIRbQ
	XH12K0HP1vxFMGHR9L2Ne7hFBG+V6WciJwCnxThPcjaQr2Ie8szvtPgoAGlJkHx6x0T58nvkyLO
	4fnIXbyk=
X-Received: by 2002:a2e:a405:0:b0:394:7f1:511a with SMTP id
 38308e7fff4ca-395d8d4d60dmr28080731fa.28.1779626512722; Sun, 24 May 2026
 05:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 24 May 2026 09:41:41 -0300
X-Gm-Features: AVHnY4KLbYRixLzEMmqDuxQ1pHKPDhIZVJe7LuADkhGnCjemCJcPUjosdec64FA
Message-ID: <CAOMZO5AHK2FF1_wws3wQsJs5ofvjn2JpQmk3of+p1+ExL8h+ew@mail.gmail.com>
Subject: sunxi: Watchdog reboot fails on Allwinner R40 after Linux boot
To: Guenter Roeck <linux@roeck-us.net>, wens@kernel.org, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Andre Przywara <andre.przywara@arm.com>
Cc: "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-sunxi@lists.linux.dev, 
	linux-watchdog@vger.kernel.org, Otavio Salvador <otavio@ossystems.com.br>
Content-Type: text/plain; charset="UTF-8"

Hi,

I am seeing a reboot failure on an Allwinner R40-based board
(Boardcon EMA40i) running mainline Linux v6.18 or also 7.1.0-rc4-next-20260522.
This board hasn't been upstreamed yet, but I plan to do so soon.

The board reboots correctly from U-Boot 2026.04 using the sunxi watchdog,
but Linux fails to reboot even when programming the watchdog
registers with the exact same values used by U-Boot.

The board hangs with:

[ 10.736509] reboot: Restarting system

The watchdog node is:

    wdt: watchdog@1c20c90 {
            compatible = "allwinner,sun4i-a10-wdt";
            reg = <0x01c20c90 0x10>;
            interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
            clocks = <&osc24M>;
    };

The hardware watchdog appears correctly:

[ 0.178494] sunxi-wdt 1c20c90.watchdog: Watchdog enabled (timeout=16
sec, nowayout=0)

I instrumented U-Boot and confirmed reboot goes through
drivers/watchdog/sunxi_wdt.c().

The final register state before a successful reboot in U-Boot is:

ctrl = 0x00000001
cfg = 0x00000003
mode = 0x00000003

and the board immediately resets.

However, under Linux, even direct MMIO writes do not reboot
the board:

devmem 0x01c20c94 32 0x00000003
devmem 0x01c20c90 32 0x00000001

No reset occurs.

I also tested:

- clk_ignore_unused
- removing the watchdog DT node entirely
- nosmp
- maxcpus=1
- psci=off

No change.

I compared:

- Watchdog registers
- CCU registers
- PRCM/RTC regions
- AXP22x PMIC registers

between U-Boot and Linux, and did not find an obvious difference that
explains the failure.

The board hardware connects the R40 RESET/AP-RESET signal to
the AXP22x PWROK input.

The PMIC power-off register works correctly from Linux:

i2cset -f -y 0 0x34 0x32 0x80

but this powers off the board instead of rebooting it.

Has anyone seen similar reboot failures on R40/sun8i platforms,
or is there any known erratum/workaround related to the watchdog
reset propagation after Linux runtime initialization?

Thanks,

Fabio Estevam
