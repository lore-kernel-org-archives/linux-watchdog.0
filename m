Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596875;
	b=x6SAR4av3UC12wzqFHXCxaTFnRCHR7+S4Ii+bRbZYXbA/892Z3gH41XZBkjWeZByn8qc
	 wUFYUXn4phz1AFdZDg5u/c9/snuu1RiTnSnEhwmfCY/oX2xmfIXCsi31abG68k5m8wyNT
	 r084oUP+bDa2GJSuNR4hmchO86bWHmfwpBNLL2tMt0kKPfPgOp5u7qLj2a2PMbr3MEbqc
	 dTxE+aGNc0vnygBIfb9dR0Gm0ZtFJY1VB6nCeeMgLOJz7pz0P6/z3hYtrrUsfm2+6kUEe
	 Ele378E6PSxwFYMSL0OrDv7iRVXjOZZQfoX/spLeGr92m8RlwDZPmom3oyheWWI5X3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=vksi6xdBiN572U8/PprSF6T1ZcI65MaLXrT+W5UPb/M=;
	b=0iNfIiAoYNxEDjyArNEVsfiR3yHZLAuS1RB8BwWgE/KqECx7aQUl/BgKcGmpT+63rZnV
	 UlcM5q4Zit86BQhfr/zrlqDUpKLlUhGISNoPBWTpelspJFwmDgXEpQt23c5gCIDedQ3Ge
	 HBOmhW4EwcWA5Ow8fbrJwVDopYjzVKvjq12Ign+Xu5E1mmWy9AWFtxjkzrOWa7ZgFg77v
	 811pONTy0TnWuk/7r2fdMiU404rl1FoQi1OnUYHW1Hkx7raI6LHKQjvX5uNPecMgpfVIt
	 qexCn93dhR1VsQWvoSyqbTEEJ2E9zdQ9tXxJXPRUgPwFsb7SUxRSy3RGhixiotAVkkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bFjkGDON;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB22660A261B
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 19:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB22660A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bFjkGDON
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c5067a2411bso255022166b.2
        for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 11:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794596873; x=1795201673; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vksi6xdBiN572U8/PprSF6T1ZcI65MaLXrT+W5UPb/M=;
        b=bFjkGDONSYnmUt0iBBDN+sBDopI7ikDsKpWVytszNlJgTae66dMDCiRZOAt5mLIY+s
         q1LywO7q27xilrn7scZ4dSAsbplZ1ghm5uDWf5LME2ful/5VEle53jfHvSJBkhpAjd3p
         O+9nm8RHUCbu6LNeCr8PQpqG9uY8s9AZpF+U4RMTeZsdd8Aov0vSFzmueef7+1xwzMpN
         6Q1jCE+2tveXveOZTjlik8Y4wllQipC/oRz/uHHKlYJH44dACS1fR3Hp1oUj628Pt94t
         uRP/PJpDgm9b6n4MM6qAaeWG3cE/6uJDdbnyGzFix+pPxfnA7fCUeAz+2RvCNZu8cGtk
         Yexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596873; x=1795201673;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vksi6xdBiN572U8/PprSF6T1ZcI65MaLXrT+W5UPb/M=;
        b=VxMrkFKUHHRm2ry9mnv5rLmEgTdiUhiBNE1KQ0WMOl4YvQlGaPKRtYdJkrEF1zXplR
         OTESBjC12jbyEg7hZs8HDEuujJgc3XK8GXIzSxwVgx8NK91fdb97KAtDwFafkdoUp2I1
         Oo6zeaMRzoPqx4k8FAnSsf9hSEmAVxMSYQ6h5jcVyqEcH3PdQeP29EYJJG0fn0hXfqVp
         badUcw4mS7VoPHxRC0E1Uqw+d7ZO7FnxQf2zXjmEbsT9P9pj+7Hz/0T9wNg9IIFLGm+h
         KZyypI9w0+JIPgH9MwaTp19lHF3s+//mzFTwGIYxEPwGG9r42x/ja5mHndKyfBwx9txT
         IEPQ==
X-Forwarded-Encrypted: i=1; AL+hErF9QZh5T2aRPLXkWMp6GAs0iH13GnHMGETxAS2RGYQH4A9duTXZfPvAaHuvlb1kV3CA/sDvdQMejmYYDCKeJA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+iguJFeARsy0VWtDAV5pqwUQ8pSqSPaELSeZcRBabHxd3mbHmw
	hqOX/S/0mRR7plwRCyVypGB29rCZLt7sHL6V2e5kBw/5IWvryj/pE2aWX92ivXoyLATVKw==
X-Gm-Gg: AYBFou0aFBXCT6UodSd945yp77C7Z/QoGWgCVPSJY6YfiEwblpAeIEWAg6KCrkw07YY
	8w8oMrRpiA6b+ts5Y/V9bZQVQGyVCA87V37NyCReRLVed//C3+b/fJMPDhItTPrjy8v+BP4KssK
	ygroa5KQ1ljTPm5WdwWVmXAqVtk+nzYnRDzR2OuDnMB2NQ43B5RaaMpgi7uVRyxWrWVaqaMeHKF
	95K+0BhMTDSdd9jLeQhTuLxv+XKtnPToJosK/WN/sRNM0t739ZILSeFGEzNNvFu1Lb9c5EDPcIt
	goKQbEi04p7JIzbODlYvVw3TFmKtErJvjaEDTsnMsUpfdrQhydvxfaDJs9mYoInctN3MLl+kHfx
	BWWDHaUXRHpdGMa17D+nN0ystC3oVxaiea/Neh6d2wV5neRrCGNAZQm2hNBu8NrcrxFWZ+B+DNz
	hZ1h8yegwTrvYebfQnK0ONAA1eNMm1kL39lzYyuuBdAmr3tIUPeIVrTSB8RXx6uaki7tisRkgr8
	8ZJQuW9LTb5mxtzu+IDveVAUllvq3YHEm34X6hK4RoN/gIkp2Z+njJyr/nrlBDl4V1P1JoFYMHW
	3i/giNqTtHPSQqvmXQI84sBDkpBzG/s632+OaQBN6y4AGYmEMkuBfWU3M+y6uOxE/g==
X-Received: by 2002:a17:906:9fcd:b0:c50:9149:48e4 with SMTP id a640c23a62f3a-c50963db437mr297220766b.11.1794596872956;
        Fri, 13 Nov 2026 11:07:52 -0800 (PST)
Received: from [192.168.1.100] ([163.245.50.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b09sm129444166b.26.2026.11.13.11.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:07:52 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Fri, 13 Nov 2026 22:05:00 +0300
Subject: [PATCH v2 4/9] watchdog: mediatek: Add support for MT6895
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-initial-mt6895-v2-4-4ab0aa9fa391@gmail.com>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
In-Reply-To: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-input@vger.kernel.org, phone-devel@vger.kernel.org, 
 Alexander Letuchiy <asalde.le1@gmail.com>
X-Mailer: b4 0.15.2

Add the compatible for the watchdog of the MediaTek MT6895 (Dimensity
8000/8100) SoC. Its watchdog registers are the same as on the other
supported SoCs.

The TOPRGU reset layout of MT6895 is not known yet, so the entry has no
match data and no reset controller is registered.

Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 drivers/watchdog/mtk_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index a210fe1569e4..d8755979021b 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -607,6 +607,7 @@ static const struct of_device_id mtk_wdt_dt_ids[] = {
 	{ .compatible = "mediatek,mt6589-wdt", .data = &mt6589_data },
 	{ .compatible = "mediatek,mt6735-wdt", .data = &mt6735_data },
 	{ .compatible = "mediatek,mt6795-wdt", .data = &mt6795_data },
+	{ .compatible = "mediatek,mt6895-wdt" },
 	{ .compatible = "mediatek,mt7629-wdt", .data = &mt7629_data },
 	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
 	{ .compatible = "mediatek,mt7988-wdt", .data = &mt7988_data },

-- 
2.56.0

