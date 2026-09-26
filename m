Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4996740BCAD
	for <linux-watchdog@vger.kernel.org>; Sat, 26 Sep 2026 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790421271; cv=none; b=Ys7KZP0+U0Xvv0VYE/XDg33CtDWyXtykKRuEp4z/OjQS1yVxlddp/OUFxr+YsNbKuspIv1Ngs4G0po7mR1JsXWxMu4TJzBN9VExOu5elkcvpN5vMJnhTL6W9NP5W9LxRZmXRSZKMVzayKTBWDqB74AOlxUcYtYnLobeEIFkmqTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790421271; c=relaxed/simple;
	bh=cmi3T7MI6QIiQHARyUJAi9tuJH7MDxa0l3Ijg7o2VCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QattwGqDzMJOG2eNtc/VcrBYhh5wsB7+3z9VHfcH+p38F1xvBTTtbNbtyylclAAUMbpOBnDvQHkt1QbbAk/PLAq2e28xBrfrOW52kE3Pr0xfLf1eVLvJXmkAf1FwuscDjjgL6E7Hfzz0r+naQAdpH0ktaLFaFIeMt7pJUH04cqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKPDE9z2; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKPDE9z2"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ee1f9bso8208335ad.3
        for <linux-watchdog@vger.kernel.org>; Sat, 26 Sep 2026 04:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790421269; x=1791026069; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VnxpUndPTtMcwTGMAPeAya3Up+u2XyfdmZAXFYObokc=;
        b=YKPDE9z2ZycZTo2Dn2F0x5MfcVnsQ6UDeRG6m9b/8/tUZv+xuqB0whoVmVeIpa/76y
         85AyVOQWNpRk/EozgL+qTUExfT+HCUu94RwqXXB45kyZ/gv+BYW74OQRO+P8Fhim+xFl
         G6jzq+hz4DZ32U6HHB5JhtwjFMgkNjYD5NLwbZVi5rcgdgHGuc30r5DWnlh5PXuVNFUV
         bWjyJGANqRGB5q6uGalKh8FRwj9KcdYjxRf2hmrTUA9Q8YS2MTUDr+qzWy61UdT82EcE
         nQONIWyqUcnAuE1v9bhNWpAdnl9G66CWnlbQGSlqyY1lcbI+XtEu9MEQxsXFxpgnYWSe
         XN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790421269; x=1791026069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VnxpUndPTtMcwTGMAPeAya3Up+u2XyfdmZAXFYObokc=;
        b=S8Eou7sWcgAbx8Ifex9R3Y6cNSqnSzA/6tmLCiGpwb4Zshovpn73LMW1lQxVhq/FuI
         6CtWmKJfJXV/hB7E6wnlHaikz35XV16BHRzMbKuvlfhyckHXpm5ceFfdUjsKIrhgk+/O
         BFDhNEIrNw8Eg3NpAKO3Xjb55XsCqoZbfX/lkOKwfzfGTCp3ZKQ/cD5WB/3Ak+1yBBQi
         SVxDS+GpW4uL1qP7gRtg1E58MhQRIJBONcokR/SHAwOfLpA9OmHMBwn1L6j70gc28KoN
         qhMHmQUP6MK6ZU+YluvpAcFnhSksg31WOiRrlONs2aUa4Vq6I7lV5OLiTJKmEzSNJEO9
         jjGw==
X-Forwarded-Encrypted: i=1; AKwUvBz0GUJ4RlH8fRPgv3VQCMqMvywaZgdrHZ+3VY6UetFHir4NMr7qy4vaLhk84M2qedQbjjckWC2uJp4rQWKeEQ==@vger.kernel.org
X-Gm-Message-State: AFuF++ljZp+FNcaQUTpwWZHSFlYvs3puJ5cBEhHaxtBBZlOBYUM+GTQe
	G+XVSt0Wugu40Repl5Vk4PfDuQKvoGxeX0EmQzihMyhNZOkSmD2qkGkL
X-Gm-Gg: AYBFou2jOlbHwkG8tTca63GggRYZt4PRuBE31raE0Xv6Rn7wd/y4I1ObroEQHWTYiE5
	T7rQH6MI5fGKgDcYIFuVyGaGIeOixzvmKEm2H6C+3HL7INeJ4CTZenLcSjk7XiME8tgssrpi2C6
	gb9kE7QAllBpg79t2+Xt+oW+g2vGxPleGoRGQP5qWlucrojP6n2vVPgpItgro8Z578FAF83BVH0
	EQxAMKxAb9BPlU8YYHn8cmdovUtZhZ4lsDT7mYFLFnHhRKkwIwC5dRLWDAjNTOrqU0+rDEAFbpN
	O/mVMHZWvgciPdRLYf/q6mk2FKBJ1lNG1bI/SpxM3XqVX6IbKXiwpEZuQq4wH83WGdZsz6ikWQZ
	k9VQin6fT2UE0sDpvUx14WHwvU1pH6gZHyx+gT8xFtlPi20U0z7O9CcuPrxP8464AmmwOIlAH49
	a4gMki0fIJDrWiUXa0u1MrzwDpPofLgFE1P7ybpANHXKioT5fcTM3Yt6RUWANyjcvpSPUV/Zgmv
	wIWI0cv5Vw4IVy2JBlB
X-Received: by 2002:a17:903:244b:b0:2dd:c100:7cc1 with SMTP id d9443c01a7336-2df7dd6d2c9mr65998225ad.61.1790421269577;
        Sat, 26 Sep 2026 04:14:29 -0700 (PDT)
Received: from localhost.localdomain ([104.28.254.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dfa60bfb1csm7247365ad.48.2026.09.26.04.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 04:14:29 -0700 (PDT)
From: Chuanhong Guo <gch981213@gmail.com>
Date: Sat, 26 Sep 2026 19:14:01 +0800
Subject: [PATCH 3/3] ARM: dts: mediatek: expose the MT7629 TOPRGU reset
 controller
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-b4-mt7629-toprgu-v1-3-c124bf9ac273@gmail.com>
References: <20260926-b4-mt7629-toprgu-v1-0-c124bf9ac273@gmail.com>
In-Reply-To: <20260926-b4-mt7629-toprgu-v1-0-c124bf9ac273@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, Chuanhong Guo <gch981213@gmail.com>
X-Mailer: b4 0.14.3

The watchdog block also provides subsystem resets through TOPRGU.
Add #reset-cells so that devices can reference these reset lines.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 arch/arm/boot/dts/mediatek/mt7629.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/mediatek/mt7629.dtsi b/arch/arm/boot/dts/mediatek/mt7629.dtsi
index acab0883a3bb..465900ce38c0 100644
--- a/arch/arm/boot/dts/mediatek/mt7629.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt7629.dtsi
@@ -144,6 +144,7 @@ watchdog: watchdog@10212000 {
 			compatible = "mediatek,mt7629-wdt",
 				     "mediatek,mt6589-wdt";
 			reg = <0x10212000 0x100>;
+			#reset-cells = <1>;
 		};
 
 		pio: pinctrl@10217000 {

-- 
2.55.0

