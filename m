Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397F236CE02
	for <linux-watchdog@vger.kernel.org>; Mon, 23 Mar 2026 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774255699; cv=none; b=S2/BTGiVNAF8JyfZ21lcilkDmwC9Nv/vPnelON5w3Aa5pUR0Fm3M3bZ2MbRIipVUSkthafafURpOIlIfwgaS+1ewa5SmF2pj2uos5mx34KsskHEOQQupGN148zp7r21RqBLl1hKgxBF/CkLZFuJESHD8IhtYbAvl3/3HPCIuW/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774255699; c=relaxed/simple;
	bh=W6NG9xgcfT4Z2dlu3OJuwD9rFp6apPLQJbr7qjrqp84=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LZhaPX9VnwKGn2RBL4bTQ7sGfp+SGFrZV0yCEBWpQ3cpkA2K2MD6+Wut9aShSaRwXBGP4cch3CuhUAw16oQ8jyKlntyJ7lxQuftN6pW3wgkBliR9QoNHszMOxbZqgi/y7Z/4ts0kXhNg84rkwwzCN36wuVKGi6x59PELx1PzU5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxHObLSn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxHObLSn"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so23344925e9.2
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Mar 2026 01:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774255697; x=1774860497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iDc+ycXXu9BZBpDDnQjC6JghUL48eeZBnExRMHFl6tc=;
        b=LxHObLSn5K/ub+jX86QTJp+NgpnBsI0Bsm0gAMkqxDSoy8w4sAuRTHDjNiW7oRYbwU
         r5qhjIh/XWSmNM1vV5di+7lQHLraCp+YcqEEFTWnO/RAoBv9bLdO+rJERm6J49AYLPkR
         jgHf7oULyiuCg2YtEbGxQREzt4Jsx9rr7q86BAmDwiVdTGESs5Uyn0t2lBKPofKFyvgP
         Am4CE9q3DqGmuk0VRzpr7ZrnnTdV8/RUYX5GU79s50uMUlcxc6pOggxsi6uxG1INr8Kd
         xon/4S32SxoyGVVxbQzt0cfpIawj+U2qg3gtrzjpM0eXxvT2xzWLMnoulWuV025una5m
         xyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774255697; x=1774860497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDc+ycXXu9BZBpDDnQjC6JghUL48eeZBnExRMHFl6tc=;
        b=V0ENkS5Ah59nL2Evvas57VryMf8D2wr+OXYdRepfNm7G00HHv7CCaEO13HlE4DTn1s
         OGxXsSK5OSTpwmvJ2BU/F5QgPxvqUBgXuPWLao6ZV06mPwuzLDw4AbBkp9gzTVy259Fm
         p4HR1KUzMlxguuv+CQkTCYc5l2PmpjBeDtcnTntXjO7u8ul5lS5p70+OXJnYIN8Ovbmv
         XRNWi2ctl+0Lik8VLhCNgVpV3j4BCoIQgYPmofn41ZZCEWoO0mbX1V1KCMSGEUpGk+0a
         HUruIPBPjJJ07A+84PKmql+MakP3DPLJ7MKPBs6gSOxsLtIFVlBzkni7PrFh5Nimg4hh
         w1xg==
X-Forwarded-Encrypted: i=1; AJvYcCWig4f+tzcLlxXFfpC2wOP0VfC/B7PaI8dgz76B4qgl9uIcHzuW2+c3Qz3mONy+aLV7pypWxXvHiUk+el34hA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoDAKNiFtI7/cslkEhLePi8krsLRWNAWBHc4KazWWqiDm6ShSg
	haav4ttx1YCIUilaOGtWtJUBOsE6JI/2U+qpRypigbP2h3UfjVQ+c7qI
X-Gm-Gg: ATEYQzyucmgEY4Q+a4N2LrWZdivlcVXGuqPAaWzHJbJ349YXsF8nK0r4xdC7kBMIR0G
	ZQJn7r3COf96NNz3K73Sv9KpLAWjKivywmAy5Lpuez5bgahGLM0IZzHQ6yCrg49UeHi0Az5DKIt
	0pS2Yn67TUELVzDOwwRxKI3VfKfExjgmgRZXiDVrzF3wC2WXYMJ1mU2nbxF2xP+Ii56GnneF/GB
	iR0vHBzS7SAFB356Fg7hgfYq0xZnInz0hQZ55a3vIK4W3ekACEnv/ZTV5GnuuTZZ3J9fn2ITrRY
	faNT0kBNYqJA919eWPGN2GEuV3Lj7AK40xO+woGCPa5O/Dp14X1ncy2BNEIvPxses0spK+y65bj
	RxXGJjrx3Gbj9sErRBGUVfqx+FosFtoCBUcqNoOv013MgkHL7TgRYGbiR1wKCOHgsfMnPSOdwsm
	+rOrPWLKxZEMvR
X-Received: by 2002:a05:600c:5250:b0:485:9a50:338d with SMTP id 5b1f17b1804b1-486fedab419mr176165215e9.3.1774255696490;
        Mon, 23 Mar 2026 01:48:16 -0700 (PDT)
Received: from fedora ([82.77.79.23])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-486fe8367d8sm316822715e9.14.2026.03.23.01.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:48:16 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	egbostina@gmail.com,
	d-gole@ti.com,
	m-chawdhry@ti.com,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] dt-bindings: watchdog: Convert TS-4800 to DT schema
Date: Mon, 23 Mar 2026 10:46:11 +0200
Message-ID: <20260323084616.10469-1-egbostina@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series converts the Technologic Systems TS-4800 Watchdog timer
bindings to DT schema and fixes the active hardware node in the iMX51
device tree.

Eduard Bostina (2):
  dt-bindings: watchdog: Convert TS-4800 to DT schema
  ARM: dts: nxp: imx51-ts4800: Rename wdt node to watchdog

 .../watchdog/technologic,ts4800-wdt.yaml      | 46 +++++++++++++++++++
 .../bindings/watchdog/ts4800-wdt.txt          | 25 ----------
 arch/arm/boot/dts/nxp/imx/imx51-ts4800.dts    |  2 +-
 3 files changed, 47 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/technologic,ts4800-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt

-- 
2.53.0

