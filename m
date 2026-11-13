Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596877;
	b=4OHyEOqyE1PN3ry8/9CVEA+uUHc/QaAKk6LGtSi+R6s70O+XzX4FFKuDlwO3q/pw+Ixz
	 bEzNFHjZUmgzkUm/qxxMgudgOJmnP72a8Ogl1r5eZPf+r9+v/jjj/PH+0yI6OFdON8OaF
	 uDQ501kSWZUHGFdN+rAnF8xl3yy0hHFJMpy6TEwmwwSmEXfbmOI/3aRA0nD9Lg7n8Cg6h
	 7WxU/cPKH5iTKQKhVgmybT+O340UsR8aJ9elaGdjYx8ddq8SGwlqEl9ehmaU/tl9qxzhT
	 HUoIZb9SNXrAoZPsWsyxDvMTci2Jqg0KYhHSRJtFmH9WsU1xfaSsSrXBOtKa7dyXGYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=N6YWRmQiNd60ef4bLmQcLELuCtQOypOA2hMcEuSo1Oo=;
	b=DO0zJGvlZPVjHoGkaS3uflKKwmTgaQGlF1ZqBXo0skMI72kogtoPPTB1ox+i9M0Gw3xr
	 lajW6rBRbLfAyWi4Y/aX6gr8yOM7tHZdZzy5LjsVDwNv+SJNt1jwo+4tqZAkKOVjH/s4t
	 rUgGpZ03jQZoUzacOnPYsJDoF+VK9PchVGonbBEi7nOBa/YmxSSLoAfzlpuH0PYmJ6TEx
	 SN5uzSS6x5nThhfbqrjD9Blank0tHCYPukeRC4tLHWCXiLeT4HUZ4H4DV37h7EsZS1s14
	 EK3QLjQzinmec0EHn1K23ST1PftHLqQzIMT3xu0AoAOfc30xLHHg5i3mS1ob7z63vjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uwGcGaPh;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9390660A380A
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 19:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9390660A380A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uwGcGaPh
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4d30639709so246619066b.0
        for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 11:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794596876; x=1795201676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N6YWRmQiNd60ef4bLmQcLELuCtQOypOA2hMcEuSo1Oo=;
        b=uwGcGaPh+BHfex7icC71WkfRYapSs0f9axsnDYJawncCBYbSymIONXbbByTOPA4Mxq
         +CThUvi39AO8kULxSYQr/f+xw1u6F1k09nzML4VhxmzWUWhRKrEMjgv2KeZZ3eAFw3EN
         g7LeZJ3AcCY9gsAwwTotWDvhn77KU5DIk0XZo5qBTBt4xvbvhUhhurEHQNLnQmTuKPSo
         g3wdA9Q4hQLuYGgtlW6F0M768H8c74wm6DdYrw8qOGQklh1OVG/IizczWWSUvUDEXMee
         U7hP5vy0RVUrnqMXRViuaOTkZmH1czb4EuZQoMFrl6qOh/lYG6qVAfp8IGf+Pu3RD8jw
         gxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596876; x=1795201676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N6YWRmQiNd60ef4bLmQcLELuCtQOypOA2hMcEuSo1Oo=;
        b=2wMJ5EoM9xH39DtMyot/RxS0oqW5ayt0UTKffxJmJZX+rVHxHgK0+HjI52i7mOecbX
         INm40G9VGpA/m1pm8TMO6sAboFLwPXb0+WwerBpKXDvnRy2WaSubBXL/B07TZ/XACK+q
         s1qIEYui+DythYaeQj1D7j5u8Im8Ggldc/Pt1vbaRLay8OEyRbqlnbgfT6zqrCMt2Tay
         ir/KqcJJUApbTQj4gTpVZxTl8O3EcmJDeqZlO8Y+KyPojPZzaAtx15/pzKZsLUXtVZvW
         zlrOtWhEVopbmI56SkQXbaJkWlXYqnwNoBiHFeC2MmhBOMtpghNdSX9nvnXuTh5VL+hU
         bD0A==
X-Forwarded-Encrypted: i=1; AL+hErHeXj2A+XLR4vknoFiHouULSph9T/CP7xaYx9GCr4UtQqZl1JRi/bFywByQ9n0NANls5IYX1UIANeouOia2+g==@vger.kernel.org
X-Gm-Message-State: APuU4Z9N8LEwKOsjZwpHV6Jwr+488RITpRKUIwlBvmfBmqmCNsYnCafU
	SCgGmuaGDAnyjNNoAuCmJDaFZyAhq/FOhC6xyvrSPeHzz1E5dMq2TKpkIE1EUBk/XeRX8A==
X-Gm-Gg: AYBFou0FeHzJp4+l0+t+Cjr+MBf43vsHDgNhgsnuEoJwmCp29ZUQSiGwP9tuZVPPEyO
	FBnjf4Y2nSOoP7momlaA5xYhUdgUCzl3WUe4e60BM5DmzuaBtGVYk6UQJMSwXJbyR+u+4At+IoE
	8eYxE+Jzd5Ip2O5WRjJxGLVpbYrF71RaoTDACWQ7td//0TOoOH1LJr6mU8A43582M/qJ9Zhefkl
	Z0uQ2cU6CJjP8CNJKPxhtrfreNJKACBZ78K/i1JlZo217aqega9Uwjiprzwxu7eCApq4r6235Wy
	BEvf3Vnk2sz6MZ2n2B56sZKjS7xDydj/9qsOcKn7CyqbZBOgwVX9tZ+98YCIJYLwROLtJWYjHYj
	NmU+RiCg3XwLjeLfzTbFkNy8+XNp62eKDXEF3H9A/Hc6nh9H7MeHO/YsZkhvfr85UbJCB9ofYJU
	kgrcCZm3F5MEmWfdWmZSy09o7sDl92gZpK+qUI/DCpIdknpWn/1Q/8fIp92JjG2v8nxMvbF/S/m
	pSYE6Dcf8VLGF6FWoEYknUuArZLY0Qpu5ZYZfmBjNo6JxnCg72FKI+ZfTTXZWgFXITzfdRe36Ip
	ofJMu/33KIvi26wK9CO3LlTuozG7VcXKZcVjkqIV0RYKDXabon6DVRlDTKXC0z8l
X-Received: by 2002:a17:906:4fc5:b0:c2d:c739:30e1 with SMTP id a640c23a62f3a-c509643c050mr336353966b.32.1794596875807;
        Fri, 13 Nov 2026 11:07:55 -0800 (PST)
Received: from [192.168.1.100] ([163.245.50.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b09sm129444166b.26.2026.11.13.11.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:07:55 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Fri, 13 Nov 2026 22:05:01 +0300
Subject: [PATCH v2 5/9] dt-bindings: timer: mediatek,timer: Add compatible
 for MT6895
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
Message-Id: <20261113-initial-mt6895-v2-5-4ab0aa9fa391@gmail.com>
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

Add a compatible string for the system timer (SYST) of the MediaTek
MT6895 (Dimensity 8000/8100) SoC. It works with the existing driver
through the mediatek,mt6765-timer fallback.

Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 Documentation/devicetree/bindings/timer/mediatek,timer.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml b/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
index 337580dc77d8..ee4af54c29b5 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
+++ b/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
@@ -40,6 +40,7 @@ properties:
       # SYST Timers
       - items:
           - enum:
+              - mediatek,mt6895-timer
               - mediatek,mt7629-timer
               - mediatek,mt8183-timer
               - mediatek,mt8186-timer

-- 
2.56.0

