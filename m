Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596880;
	b=5ZrZjunJ2b3zC0832lU6Z7Z59gm75gKKht+EQwAAKSVTpgJqAkZMlls/JqPCpQwEHejE
	 y+wRQqWSMPkmQQvpUSRFNFrYRvg7Zh9F5rUt+i/jxxnHv9X105Mlsp0i7bCTxSMXJNeH6
	 My05nBAtvwkmdmKg106gtUijpyq6sjDrgk0YkUs1Em4QuJb6F3rbw1MjANiGSZCNDA9hP
	 7Vm6I7lUFmF21CYdMzDKUcBGBSvvXxOpNudWCvNYjfKkCS/SoHCh7TAL6xWPsgAaniJqo
	 zTX8duk2Zdb5aakZBs+o/DuCc5jP3BMU2RiRSMSZLK+W5TcuzB1Rm/4AV0DmTPmEj2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=XeIdUEn41huggshJVY5dteXJQUSowVHL3L4Q/+1iZEE=;
	b=aGcO9fIKKmzh6OIUMgN87xz8jG7tLWD9ZjA2bYGC745s6nXu7pTHQm3P3AOQ+3atUBY+
	 IXVJS77Qs22e2IlQtSdQxm5xWCPSehYthSqEIH/ck6ip2lfftnksu2qWFeifeVZX616cx
	 dNpH5WOGOQECNYbhjaQSf96NxOG1u70Hx6A3wM/eJ9bxCV3JegPzHui+py+s6qE9AUPEr
	 6vEqyEX0oPay6hDMwceNLTGKokma4hRBNI0psxEtgdmTgWkBIsjOy6GEBS2XirvTfwGV9
	 vrwRJ0LZv4W1CGOnCK+PaM7cVnTYGai1H3+DyqODxlfQ4aBmISO6bO0+Acx78wb5VWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=abdJekNZ;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A85606A8AF
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 19:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3A85606A8AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=abdJekNZ
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c45551fa84eso342009266b.3
        for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 11:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794596878; x=1795201678; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XeIdUEn41huggshJVY5dteXJQUSowVHL3L4Q/+1iZEE=;
        b=abdJekNZ8HxFrzNGohRBeEoTf/523bitcDzqsMoXfu/U4MopGkOP+b8MXZ5tWxql83
         +H4idS6CeHAz29Ea3I8Yr8DkY2D1+ljIBctRuNZ1EQHnxCBrrSzbgBs4xgLyJVibQTIQ
         LYPvOHevrIg4Xv1JpSAMiLR37kb9Qq0S0VvubHWWazdzfJLS1TikFNzYi8HMMVqCOQbI
         eKti5JdPJe5aXqzgfLGy8UYM3/T2YWQ3JRtjF20hkIhmgBcvDm4bRhNg46dcYztv2oc6
         BEcFEfaaFNumUsm4LprF9aHBwJYDZeY8ItR+D6Dw/wamqL2ToslkaAQt7JXd/JPGbXXY
         Xx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596878; x=1795201678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XeIdUEn41huggshJVY5dteXJQUSowVHL3L4Q/+1iZEE=;
        b=lwS8Plszg+xaY/RAPsLncRbnIOutRuPqh28gA1bcPEGSI3ml+9FmgpF9IiZmGWVUUm
         O1Ov9fmUllkTuSS6bnckA0xOh9lB8UzXXqp1NbLXUkDmBXimKXFsUN2jEnpfJZ56naqS
         rEUzfy5pIP2tZ1A1bV55FRb8WxO32oV4ReQFvQ75TgTNRpGUg2dr1b2z8H4rSvOAKIBe
         OBBUnZS1Y0k9g6RdkyzrUhQhCnhihlYAERQk7T6Lp5TGdeujxXo+Aj2Tg69yjEwRXupG
         X+m03/LrphCSK6KFOG1P7L6SINRexFzrucKCNKXEoQr0sxEcbw3xh1jFaRi1hWxml8vb
         ZzDw==
X-Forwarded-Encrypted: i=1; AL+hErHttxgcUfPCku+B79mkFkPSgXyXTsZxDV8BSz/xtkvPptItIRot1bsPVX6jCqxAyzo+QfGE/AD3WqN9a55KHA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9oTXAR7CT5LWoexA4lqth1N4lJF9JMqksVvLQvjC0lmjei9hfJ
	NM8Y3AmUx0Xq0YFbQAGiGmF8CZnC2Jyvi198+53896QqpgobPOGKUbP1DP6gbc7L+fNeRg==
X-Gm-Gg: AYBFou3U4BWajlXpP+z4k9O6xIWPgnEyBEtO/u8m+IbNA6Fi7NXSrYtX8MKhBFgfUZj
	YWYOqTN9Rj3El9k54U5O3avr+FKZEradUDysz1mT5iFgDr+IMFXuoTZwhupAj2s+V/9+cKxqYU6
	9yIcnEIx2H7vlrS4sV6RFXngl/dD2neg+YHL9bgqI6ZB+9/52kh7J6kb5I1RfX+KZ3PY37vSzEC
	MZFIAmIEM66ItevW9A3Q/iINyuCHSQkgD0LCEnKHlpUXEiCnPeYGIFTGldaoMUQR459ZKBLfpvJ
	G3RVxgRmO6Bh385DG79rJUSzJ2hvQ+8q0aod+QgPqcqhw0DtKNpC86Vh328Nk6FGjFnuY/3xTWf
	szO0sVo3SZ35GecsB7AZYinKkUiPxpd8U4uLFzi4UAdFIkJoApbN1n9wAtT26Gf/QzfJwdKCYwv
	6jWS4WzRy1XH4niV/CfPH0pUfv8QnQ1Ou7sdiLRutuJD/IsqH+ss20GkZSPj+mgwjcbuDNsIRpw
	BwCAH5+686F9rDHajanKRwxAiJTEDod3PMKq6D416FyIxzECczAFlmFQZxaIDmn4rcPrNwsfeX9
	JQvXHnqnfC5BN6q/vP41AgT0LmtFP4cmV8YalaWQJ4BPGGNimLrgzap48/RcuDXI
X-Received: by 2002:a17:907:2d89:b0:c46:8063:220c with SMTP id a640c23a62f3a-c5096398047mr303416966b.11.1794596878270;
        Fri, 13 Nov 2026 11:07:58 -0800 (PST)
Received: from [192.168.1.100] ([163.245.50.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b09sm129444166b.26.2026.11.13.11.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:07:57 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Fri, 13 Nov 2026 22:05:02 +0300
Subject: [PATCH v2 6/9] dt-bindings: input: mediatek,mt6779-keypad: Add
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
Message-Id: <20261113-initial-mt6895-v2-6-4ab0aa9fa391@gmail.com>
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

Add a compatible string for the keypad of the MediaTek MT6895 (Dimensity
8000/8100) SoC. Its registers are the same as on MT6779, so it works
with the existing driver through the mediatek,mt6779-keypad fallback.

Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
index 9f0da1240187..9a1369c9ff4c 100644
--- a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
@@ -29,6 +29,7 @@ properties:
               - mediatek,mt6572-keypad
               - mediatek,mt6595-keypad
               - mediatek,mt6873-keypad
+              - mediatek,mt6895-keypad
               - mediatek,mt8173-keypad
               - mediatek,mt8183-keypad
               - mediatek,mt8365-keypad

-- 
2.56.0

