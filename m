Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596872;
	b=EyYjudM/A1ykEO54xadauKoItX6e6ohzaU0CK31i7DYfYiKK7Y0egKFC1diLpOcNRdyF
	 rd4FnqMxoZdwNWObUNPu/17Fa+r3I0JQXVGFJdeVl2S/ly3F4/CYmCFZ53gcGqfIg2/iE
	 Ys6VJ7N5CllpX1eHR3L57Lib7XAmhmn8StrGQKYkajrMSiQEbN/U5dJxP4L5lL+udNR7p
	 J6co3KppKbDZwCe7s0p4FglF8n57YC1fZPiF6gz/whNUOw4cfSbIQNR5I5Ytdm3DW64ie
	 POFoNuKrR6HhDVXx7JpwwGDzGGG9Y14pZUCY+O6ElRPOieuw6vw8jINFp8taXM2Q0ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=498bVPav8qEVV2GYaYtJAWa131hP7OjDlibTUA65Q0o=;
	b=CDgEZxRDxoxnNd8NiCDEPaJo0toW9Ipv9dA3Xez0a5Zre58+B3KcWj2zi2/74m6r/91e
	 l8vRCF3GfF4Lwz39TjXgV+6TJzKx7N++Df9i3qj40MNc1JQ7NFDqKeffFbQRboTFg8ot+
	 dwW6B7z8CaC+bkUqrg48p+PCZuQUEoK5/ciTB3DNYn8UpG2Uaq9WGtyVQ5DWZQYxfcKvR
	 h8VhqlRJJRzpY1ZBICZaE4YA1+BmOiaV+EXnIiwcquLvf/JIJGqYgsbg7/x6g1MzI2gpr
	 QfXDpHDSqJ5wSi4suMAXoQgEcVMTD+34eSdSEdZ9zuafbOn1dK9cQzskdO74qnrjhrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HePccj35;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E4060A2619
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 19:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6E4060A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HePccj35
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c50abd5b4fcso65174866b.1
        for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 11:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794596870; x=1795201670; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=498bVPav8qEVV2GYaYtJAWa131hP7OjDlibTUA65Q0o=;
        b=HePccj35FvhTjvXwtdVBJgEGNVeh2KrOUDPZqigubVdBbr/KLsuRN5y64YNXHBWId4
         m5z0PK1xgJg2mvVjc5PNTWLFyq96goUIFhvhIPhZLDaMHVwkfH1EPNEemnp6vzvRPKLg
         Yuy1HRPofIJAEzZc6kSFJD1IKjUzSort9TdQEdO9ff62aiFdDCjMk7tpoNy2qzHJ8s96
         YMdgBD2K4ZYcf0zITt9tCnTJE3UbVZJCXEo3J7dmh0cYnycfUhsDbPWzieA+Tru3tD+O
         CE6bH2un439G7EPfZMZmwydwevOgw046xvR0kNIjHzWfD+tp7t1hWAKcpujb0Shia4NI
         mV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596870; x=1795201670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=498bVPav8qEVV2GYaYtJAWa131hP7OjDlibTUA65Q0o=;
        b=1Bj4cLqqIRs+nWofE0OPuWdVO7my/K4FysPW0AwlIbtxHME/7ETH10yVnn+C5tHYBF
         RwdjKFm1LL5zWO3EL55h6JRKGd9x8qg5BR1+cKurps+PUPkydGXHKMzI7kd3upMJdPna
         d9CMbK2wLAe4qTXLJQfMgU/cCHgNhFj+nynoZHfP0VabUY9qKlLJxAd0ALRmnEKBVWWx
         hO8iNxWTmCR1YYfgc+fw25/PbL2BLSKZwgt9etRVJO0xZUolcM0WMw8T9n9W3Wagq/bB
         IRHS50VQWXGbjcK6Ap94zyEwsZ+Yki8U3LQjZdeuw5LguHuO/v2/A8Z4gYO6jerg9hEQ
         2oLw==
X-Forwarded-Encrypted: i=1; AL+hErGGUsFpm4gfRnx9W92CrhlH9W/JtjChsEwcRrcfxANsp5hzF7MAFOiJdzzpwsEJjpSuZtBteeEq1FIf1dfg/Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z/jbdsB87mDV4j3tPUnwuReFKFPouaju1IWScxxyBY8OYGU1wSK
	WrMHB96F0N4PSGHxUZn3Zx/SMwal4D/m5TBSRk64jvko9S4qLr06j6GR2QTxurj9X3gfeQ==
X-Gm-Gg: AYBFou3gnG8Qw6P5ja0rUqtTH7qNPnotVe1W3i6FkR6I35wKx2vfq7bf4XJuBtqOxgq
	bLct24+CfvghO2cBrbQtToLTdyGYZd4+qsKSgtN4Spn68WnoG1fEbfs1cAaoTEbdhufH5hOhYQk
	9h5kAdn/cAKz6Hz6c+ffg5aodt3tmW91019NkhUpsotg+qLOwCGW4cISnlNfB6tI2ZCueDa4C2k
	05lwIAbJkPhsDDp4faeHovrZ4jQ2Nc1d34FGuC0J/jhxB9k1Bs7lNlDz2ntJlxB8jIcFis1xVhT
	Iz42BBfwHC1bJSj4m7wExcAJRM3DNb/XMoYoiT5qhRyPetdtjggPUVzN1QHmfCoNyovz2mctBI7
	MzBD4PBOcRJOz8CANhniqUpfyuBjWwCKB9pnvPy83+sUtGYPLp/lY7z6Xu10I/FwYAKZRYDvKe4
	0nXMA2O9xAwkOooxWFpFhhDWS9CFKgAjOC/JC7L7/Cka6eBsRyMiIddo9+JSY0lBWucXixhKLbO
	DB5I8+QCeNAmxvqWjtw7WOI9qRFVZ4zC+8Ff098SGW/9g6MD596pcB03Z5+OkfJXZRMcuZv3x2u
	Fc51MG6OSurvYYQt4IS0hQylkVEiZuevccCTFoyWlaex1FEIOTM32puFxLChy76q
X-Received: by 2002:a17:907:3f02:b0:c50:5186:6dc2 with SMTP id a640c23a62f3a-c509636b5f5mr389984566b.24.1794596870123;
        Fri, 13 Nov 2026 11:07:50 -0800 (PST)
Received: from [192.168.1.100] ([163.245.50.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b09sm129444166b.26.2026.11.13.11.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:07:49 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Fri, 13 Nov 2026 22:04:59 +0300
Subject: [PATCH v2 3/9] dt-bindings: watchdog: mediatek,mtk-wdt: Add
 compatible for MT6895
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
Message-Id: <20261113-initial-mt6895-v2-3-4ab0aa9fa391@gmail.com>
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

Add a compatible string for the watchdog of the MediaTek MT6895
(Dimensity 8000/8100) SoC. It does not fall back to mediatek,mt6589-wdt,
which implies the MT6589 TOPRGU reset layout, as the MT6895 one is not
known yet.

Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
index 8e8991ac95ea..d0a73b9c81d6 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -24,6 +24,7 @@ properties:
           - mediatek,mt6589-wdt
           - mediatek,mt6735-wdt
           - mediatek,mt6795-wdt
+          - mediatek,mt6895-wdt
           - mediatek,mt7986-wdt
           - mediatek,mt7988-wdt
           - mediatek,mt8163-wdt

-- 
2.56.0

