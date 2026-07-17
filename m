Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3633FD121
	for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301308; cv=none; b=OEExrIKsAHjue0helZN4QxQ0eb7KtnmY3z+UiSc20nL2FLG0TrtROktZ5wS2DSirAg+8N6TrXdgmGNtKfSFe0Ggu9wNl8Ye5pxDh6MIgh0yl0l/NbWaK6aLIhfVNBiQcmDDu2r9uPo0L1E/oiFKvdtLfdyYxIyyuAKyDo//5Wn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301308; c=relaxed/simple;
	bh=FU6qDeHF6G2wnG84JcolMJ3imCNMGWHDGr+KH2C0qSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ko9kLucxoocdVQbkDeHbHW9I7jdUaBlYYT6/QwrbS43LIEhQrMb7NffZqSgyo8DwxaSU9DbC8t1XnrgRiXeC1juA8D8GEMTq8SEQRFmXAjIaurn+Nmi8j48FzERLvuv4P8HWLALP8spgygEZkwlXf1+nfxB1p6SbzfTkEPHLHsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G546tyIY; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G546tyIY"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69c7ab350e9so9482422a12.0
        for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 08:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784301305; x=1784906105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kCSbtpTfn0tjI5mWiKnAehObxNB5ridQJcKUxITI8TU=;
        b=G546tyIYoj7X12dyMOeaBrH+YPgyUMrKGCqpOunVxO5bsMAaunEa7mxyDQWX5MiYiP
         VememLIZHKhyYcrbrnIoXlD9XfTOe+9JwBznXHcwyi5tqyIJiPqBfTVXdsG1/lIh8zUg
         Z9taNV9w4F9ZG6dCb7L3qOSy+m4xEzjzd1Neac1Dfxb4McATfce02ffCJ5oHFak/d0w/
         yi4YzpwdzifD11ZzjQHw+ZN/VINC6ZkXjskjC0sUlp12355Dx30pwie1KzreC/vu/qa7
         /nZBxvThBZ/RLDK9w3q2IiOjCftqeSmWzVLohXgQIOBoUo1i5UXd9HPacJ1sJx3k1ZPB
         /KpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784301305; x=1784906105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kCSbtpTfn0tjI5mWiKnAehObxNB5ridQJcKUxITI8TU=;
        b=nuIqor88HCk+3PVix/dHO6YPmGC9h5+2Mx5vZT5EQV7KEuKwOexM/8MH+m+727Tb/g
         Hnvg8VJwlb260+00i/wB/ToQfpz61EuoFRyaoV5QyMiCE6L6ztkob7q8UdQfEPk9DaGg
         Ci+nInQZmPNm10gg0jWmvWNNyuDNVTtyPIP3LMyFW6wbs/Hcl0zbSmMiSRlCPhA3fhGR
         DVZ5zOkkBW6qx4dcHfBJfbEkPFsdmKijmAjKhXVM9uDINQhw145x4hAiLotBoIvGyJSL
         XiTNwuRqo4XkpCXn8WmbkyoadIQaqdlXJsruw9wB6XZurHQ2G2u9mIIY8axGfStKrZzR
         vs+A==
X-Forwarded-Encrypted: i=1; AHgh+RqyRLw24UuKNMf0Avnmjr+oE+Ikyf7jAWCGxran3cld0mfcg7nQDntAo0mAGnb71oYMTSoHNSbwzNmoUfKEZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjrOrVxyr1+HebNCR7+sslLv0WhNYEIVb6fO3eqblKYBwBK+y3
	tZvDUUFEMm4ttMoLyt2vqH26KCu3xTpK73M7DhBkKyaRd2BX1GUS5zZN
X-Gm-Gg: AfdE7cmp5Q90j3VYeLrTebo6XlnROrbF9Cl/FlUhc9Jrjpt2azOgzZtxWc745LJdvYN
	45PflHtKnYmQ8rPhZ8GaTfrjbD9vKKF5en61Jbd/mcfrAducEuaPaGFolgbnMYrfYPOT/UxgsOP
	QNr2ctmRhxdN/1j88JCI3H8rYaV2ulLuNbvYXIM0b/YGMkpgG22mPAv8oTXwyHIc1XgGE2MlCUE
	SHQnqJdg6284ZBibDnQx5AAro3PQufyr+73U1sAK0aBGIM7tSMczmvEeFIU7Ok7i8ETCHZucjuc
	D4JGRuwd4+FrUwn4b9YZjb9ktJEl9zb/xrwX1AJnpw46LcHOqpKHXWZ6KBNjRkIbIacg65Ngh9m
	vWyMGOuWTmsd/9DAhOB9hsiEbuofWvaoDMfvBo++79qOZ5NtxhtvR9yh+ECf+VK6MBdk5niFKXQ
	==
X-Received: by 2002:a05:6402:388c:b0:698:81d7:b822 with SMTP id 4fb4d7f45d1cf-69e652ed680mr1129854a12.22.1784301304599;
        Fri, 17 Jul 2026 08:15:04 -0700 (PDT)
Received: from luca-vm.. ([109.52.116.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6ffbab34sm931684a12.14.2026.07.17.08.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:15:04 -0700 (PDT)
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
Subject: [PATCH 3/7] dt-bindings: watchdog: Add compatible for MediaTek mt8167
Date: Fri, 17 Jul 2026 17:11:10 +0200
Message-ID: <20260717151134.678839-4-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717151134.678839-1-l.scorcia@gmail.com>
References: <20260717151134.678839-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently mt8167 inherits its watchdog from the included mt8516 dtsi,
which in turn falls back on mt6589-wdt. However according to the data
sheet mt8167 has 15 sw resets instead of 12, and their order is different
from mt6589. Update the wdt binding to add a dedicated compatible for
mt8167.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
index 953629cb9558..f514be8a5851 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -26,6 +26,7 @@ properties:
           - mediatek,mt6795-wdt
           - mediatek,mt7986-wdt
           - mediatek,mt7988-wdt
+          - mediatek,mt8167-wdt
           - mediatek,mt8183-wdt
           - mediatek,mt8186-wdt
           - mediatek,mt8188-wdt
-- 
2.43.0

