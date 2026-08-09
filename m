Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E3F37FF66
	for <linux-watchdog@vger.kernel.org>; Sun,  9 Aug 2026 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786291628; cv=none; b=XXF+mOkCmVTIvgs6WwuI6CSE2ByedJ4h9hHwdEKTqpwEbCT9/cTpxleAQI61GNWU+rXL738fzbzgYASRtAgllHEpDUXe6A/8WiuysiKjyXp0684EM6j0ElXAGOwmwNRcLlRbWdZbySPGAvQ2RgHCk8ZSgZKn/fMCreLFO2BMkm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786291628; c=relaxed/simple;
	bh=JhqLBdq3WIVPgiAIXgr32xpTA1kFV1wyKoQGDAs9nu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tfhz6hdYf7p5ijAMaWAK7iPJ8QR82qAqUbN1f+mtb4TLiQqBtx7JZqJAk4hXx/P0ay90GiI8Bg8e1E1LZlzTNzulhlAIxF0S5WXtLPBmRL77lrgZ8cKI6GXDF0nawfcP8WhGOmoNu1ppXDtDgr7Yx5u+Dpkm9TMZ+EgfpIz6kl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7FHFIdx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7FHFIdx"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49553515a8bso16952545e9.1
        for <linux-watchdog@vger.kernel.org>; Sun, 09 Aug 2026 09:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786291625; x=1786896425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9XbMehx8K2bZ2mGpb16Pwzbd3JSYKI87k4OfxyTYe5k=;
        b=N7FHFIdxrtvIshC6TheTDSI0hT3JHo3gh1DKlvUbeIUTTb9rf9zyjj+I4uvNxGoDJm
         M7qLm7q/DMEBnmp1zjuGaOXipPh0r9m80uVSslvX0cQLar8lWgTgQA43w27tvnnaTCNL
         5MIqXqzpHlYjFbHLyHcEDb04A9vVljW5Cm1xjAt+8X0Yhrr3rRxEgS4ypkSha0IRyipG
         X0AeZHbF8jejUJIwNzJ4TynWRHQWPeNU32ZeS/yPy9RbdR04HgSYZ6beF6F/4Ju5YgRy
         eByrGJVVnWIFabNqzi7DQwoZkdWpwxreQ5iKFkaoRkm8oZoFW4GsF3Ze/Zu+vhOCFCb+
         vxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786291625; x=1786896425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9XbMehx8K2bZ2mGpb16Pwzbd3JSYKI87k4OfxyTYe5k=;
        b=ZIf6+vGPalzXONSypwy1QwnhdOKUfh5+fGE53+3oL6KAso23tys99+ut5GrSfY3ort
         qHiNTBRjDtzbU+LtPCyXR57K+V+hYesaK6pzILghkUORofafZIXaIFnKIYZibxcD8p90
         sUdUMMEObjPW26sUbBwrRrqLTym3f8B9C3ueKPrQOVrH+nv81g+d7Jl5ZHqIR7S+OWaz
         oVwYEZT1qqY6xS+pWJoH35qT7DD374Uacd2OUlfPsWJqkQFdahjMLqy8KoJXgujElQyH
         K/ahaLE5VNKRMp4sIJIxQXvzExHGIhVLwFVDoqc2nplYFXz7Wv5+u95IZjg98IpEP9TT
         zHRA==
X-Forwarded-Encrypted: i=1; AHgh+Rq3CQm9huY/WPl5tm4MkMzvqkMcnu6S/Ag5ruOl6hTi9/fPXShLDyLAB6XCeKxDHEGKU/r+nWzTl/4MsHr7ow==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2WfRpiTielZDMOkqwzIjxC4NtOd8UaZtQd51oF4RNLT9sO1+E
	mEAwOVOy/9iX9JSSzB1EWSBG1iufRTVyFt8JLvKPVlgAKOVGVzjaFur/
X-Gm-Gg: AR+sD12n/CpHceaot09ZFQaySlxTrLE7J37LeZBTXrdoEzHU3Cax8S035cROFKrGaZf
	wsDJFJWruLeXkTeZHFPr7Do+qEhYCUmhC+3qhSwGZYBBmdT30vyrbC/T2bG+90O6mQ+y6jr3Q0O
	SJkqbdButr56n0Ds8awYErHKgRo+MABw0wuaS0mZIuLb75X6z3uOAwIUxz7QvprNXozUXdtYsQZ
	jUKsqPhJZLKislvE6+l9rsQ1dHizh0vY6AR4ZlIS0gGKFvaJjigFqP7Wf/hrL+Z2dIjT+HyyA3d
	1WILSvLUtLC6BTtPMm7j3WHNwSpalsa+6WpaQdocqvpQygQz2j6Al8Vomg+K21NJaOSteHqk0UQ
	H9dvb45lRaK5fJgpXyTJWtsSWoVZqVVDC93+VHaBei3dGhxnWOlUY064wt7UdSj/TwEfzNbs+PW
	SIieFsSRqmAeFiQ/QutpbnzXEiTIAIIJAEzRrgqMmp8Fitx1uVNswk0w==
X-Received: by 2002:a05:600c:1f85:b0:495:734e:4825 with SMTP id 5b1f17b1804b1-49959e3c571mr301623835e9.16.1786291624921;
        Sun, 09 Aug 2026 09:07:04 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c7b2b68sm209832495e9.4.2026.08.09.09.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 09:07:04 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/8] dt-bindings: reset: Add mt6589 toprgu reset IDs
Date: Sun,  9 Aug 2026 18:03:25 +0200
Message-ID: <20260809160643.33991-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809160643.33991-1-l.scorcia@gmail.com>
References: <20260809160643.33991-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently mt6589 watchdog driver implements the watchdog feature, but
not the reset controller feature, which is actually supported by the
hardware.

Add the bit definitions for the 12 mt6589 toprgu resets, which will be
used in the following patch to enable the reset controller. Values
determined from stock Android sources.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 .../reset/mediatek,mt6589-resets.h            | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 include/dt-bindings/reset/mediatek,mt6589-resets.h

diff --git a/include/dt-bindings/reset/mediatek,mt6589-resets.h b/include/dt-bindings/reset/mediatek,mt6589-resets.h
new file mode 100644
index 000000000000..ee08c39df513
--- /dev/null
+++ b/include/dt-bindings/reset/mediatek,mt6589-resets.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>
+ */
+
+#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT6589
+#define _DT_BINDINGS_RESET_CONTROLLER_MT6589
+
+/* TOPRGU resets */
+#define MT6589_TOPRGU_INFRA_SW_RST		0
+#define MT6589_TOPRGU_MM_SW_RST			1
+#define MT6589_TOPRGU_MFG_SW_RST		2
+#define MT6589_TOPRGU_VENC_SW_RST		3
+#define MT6589_TOPRGU_VDEC_SW_RST		4
+#define MT6589_TOPRGU_IMG_SW_RST		5
+#define MT6589_TOPRGU_DDRPHY_SW_RST		6
+#define MT6589_TOPRGU_MD_SW_RST			7
+#define MT6589_TOPRGU_INFRA_AO_SW_RST		8
+#define MT6589_TOPRGU_MD_LITE_SW_RST		9
+#define MT6589_TOPRGU_APMIXED_SW_RST		10
+#define MT6589_TOPRGU_PWRAP_SPI_CTL_RST		11
+#define MT6589_TOPRGU_SW_RST_NUM		12
+
+#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT6589 */
-- 
2.43.0

