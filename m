Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794042792;
	b=qrICl0BztvEN3+BgM5QEZVs1pRzooqlkOc84vkIVHaWdnljJ1UoKvrcGT9xzSnyrU3Xg
	 pSoxRY6HA4yTHbl9wpI2PspdwTi3ZzutqEkQtTQcmiwxhHttWj8eXz0oZipEYKIdagA4x
	 M/W0p0gDJUz9etnwq911QS/Yr3Rn4Mv9haFkMMKmt95akyjujQBwLNBiRl1LxW9MmuQkp
	 n9JSbimLAKyHB9N6CyWxIpe8Djhg4eKSRnwoClvNolpFMxL6i1ptppZvcFhEjKvrLEyre
	 8J7WCrsDtOrWUfSggoFJ8oDN8WATZS5vj5jDZyhZNRBYT+oJt1LpXgfNzbTh8Kwu0yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794042792;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XBdcxSgsOzWhMK/iioasbAbzzS822OCTsFGBZkPYLKU=;
	b=p91p4IUpFddIc3M9inEeqdgB0IWnrhNBd3OvY0c/G+vEOSKSx4NYefT64Xlc32C6KOlK
	 uDu4I78AvBqquvC5X/BSjCngT8uRwyhTiLEGqOXZD+y3OC50N14RWY9P2e9lFlH5fdC4K
	 F8M2YLW3m5+96uqXP2Py0SXqG2vB1EiOgLa5TyvHZe7KzN8yzFppMT47r7MxXSYmreFIg
	 sZ9coZypIBy7YGPlcO9jbp3Nrh3eGNypj830GRowjCd9WItFbU491Katt+h2odvYXV2zg
	 oTz0zyWLjdMwnACIa4vlroyv6bdwt8nm7s/6A/HL5YQSA9Y/veUVeherIiSOz6yOuvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PpC+99v8;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E834606A326
	for <linux-watchdog@vger.kernel.org>; Sat,  7 Nov 2026 09:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E834606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PpC+99v8
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b566cf56c1so1503553a12.2
        for <linux-watchdog@vger.kernel.org>; Sat, 07 Nov 2026 01:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794042791; x=1794647591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XBdcxSgsOzWhMK/iioasbAbzzS822OCTsFGBZkPYLKU=;
        b=PpC+99v87SaXQw5ylR+lrr5/ZH1RuePq2a1OgNLIaS38ZMR3RYdF4hx18UtoJrK7Bz
         cDz8HorQo7nEY0LPSKTZJ0+VMfpgTFB/fmQTB2MnwtwzApPlWBQJZT9bel1Pjxup3zPG
         csiFs1kIsgXuQWrnGe1KAI6bR2n+MkMHxvtZILO3Al90D21moEeKF0Bnyu42F0dO+BZ7
         9yDp/t4S/08ii3TJkTRqrxZzM5ZnmckjZKZkiBk1R0G6GorJGM0xCSRXZRD+GJSkVB1B
         GHrcHStlZaKqCFZ5DEUdZrm2zaumoa+ZDclAgNgITqhw6brOZOEC/Wex6PDojgg3fgnD
         g3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794042791; x=1794647591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XBdcxSgsOzWhMK/iioasbAbzzS822OCTsFGBZkPYLKU=;
        b=LKhZRM+JkpTnRPRF1al01O7201+577s8i8DG00ANYmDVu8UX6rxp9P1hqLtEzkgjjl
         gaEwK0I9eIoJOx+l+WTD05FgSuSpQmLuKFNp9A9w7WrakJbL+vOLGs9/l7D8tbny7Ac1
         wUkpA1O3tVJLcqvkjMBlfml7xb+djgD6fxyqr5rPc/VJxJr6gqy71KDDRJd+3WUTmj22
         wRZYrkOAMiv4k5C0TMJIon9FC6OoPfXXFvNBcS3RS9sQqFkg4xjesKp5VXWzOt209SiH
         EF917eX1hjSe5a+NFBQqQQr1YhugBAEOgC/xstedi2apxpkgZVY8hUFypjtRyaVC0O3k
         2xhg==
X-Forwarded-Encrypted: i=1; AL+hErED7KQW800Lg3cFoTKcfSpDkkJ3Xha7BwaW7SaLvKhNE4NQJ9nQmZvjxZ3LrIn+tCi93AiJd7G+UXWqGVjR7g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+fo50UQ14uLonF/dUbh/ykshEQfkUgQMHapg5iwU2O1vEuzhrL
	4iuXxkBUXwfkt+75KMZqwrpAVmX6BLPiw5T/E6KtW8HyU/4JTDjzUSl0
X-Gm-Gg: AYBFou29smda2qS10bedF0AI3cVxCEVSHdhTilwtA/V0VC98dQRWxbnRxS3YMv5iFM5
	1+KiPzS50i0wmw6w52cle7hs7qVWWuvwj6mJ9r8CgISqyTW67dIiMvwHVm32lrcfwaC4/M8aB5w
	L2MZzT/y20LpthJ+7ir9URtuiI7VEJ5eASqX/fNsbVOIkQl/6b5JkV2F8ryrmZ3gVgYQvWT+z+t
	jhjU2uPQ0AsH5FQdx4qGjzIML1sg7RtaiHeOUiX/LnelbdD3/SVXCio2CjxFXos+96gAXh1MCX8
	zZeQHeGwVg/qvuqE5IJJT+CoRPfvpyzI4u5B4oTsnGIOTAD2eGhQhg2HGcNKxQe/woNwuxDdvUR
	odd4y0g4/IZY6TWv5mbVwiFjxLjbUI/I/LTPXmfAeLxa+dht2iMZxJcTzdr9hnfBo6fWN2VfQqw
	gqX+y+2WZ2xkPG1aS//JSAw5m02jMSSHbLJVvpfo69c5exnVH89c12/xPNcBYvPbnRTblYYffeG
	PdD4/qVAf8NR5AqWAgXCzLkK20Bm0leShHP+WYcmE4dGhl9suortxt8q1dvZtQv5B5tht3MQFan
	wC0S/p5vlypxQTVmY0o4FOXkVB6wbknHOhf8dP6h2FSNylRtCg==
X-Received: by 2002:aa7:c3cb:0:b0:6b3:c422:9257 with SMTP id 4fb4d7f45d1cf-6b597805d85mr2374834a12.25.1794042790711;
        Sat, 07 Nov 2026 01:13:10 -0800 (PST)
Received: from letov ([62.41.24.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b6e82bc5d7sm1405043a12.13.2026.11.07.01.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 01:13:09 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
To: Akari Tsuyukusa <akkun11.open@gmail.com>
Cc: Alexander Letuchiy <asalde.le1@gmail.com>,
	Roman Vivchar <rva333@protonmail.com>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: watchdog: mediatek,mtk-wdt: Add compatible for MT6895
Date: Sat,  7 Nov 2026 12:13:02 +0300
Message-ID: <20261107091302.16545-1-asalde.le1@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <au7UMdlP9O6oo41i@buffalo-ssd>
References: <au7UMdlP9O6oo41i@buffalo-ssd>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Akari,
(Resending as plain text, the lists rejected my previous reply because
it had an HTML part. Sorry for the duplicate.)

On Sat, Nov 07, 2026 at 08:18 AM, Akari Tsuyukusa wrote:
> Please give MT6895 its own "mediatek,mt6895-wdt" compatible without
> "mediatek,mt6589-wdt" fallback. Its TOPRGU reset support can be added
> once the actual reset layout has been confirmed.

Thanks for the explanation, I missed that the mt6589 entry now
registers a reset controller. I'll make mediatek,mt6895-wdt a
standalone compatible in v2 and add a driver match entry for it without
reset data.

I'll wait for comments on the rest of the series before sending v2.

Best regards,
Alexander
