Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681807;
	b=oTKQBajQ1/qXHD8Zk+XIGihQsDo7VTeNkyqiHrNxWnspkDc2yVGsZZ93pE7dTCbj8Feh
	 /HcGOPfJNrjSxzILXij/U3kMEonPOiTfYhf+CQMC1H0QR3lBMHeERTZQgSncJvY6jtbfD
	 8NQ3Fb+R3e5LrjC98u+2/q9XuGqq41PZrM5j2pj869ASEfh1xgOvZ8JKpORkLOpbkSNgC
	 v8ehcd9INPQpDTbf2NgWCIG9DAXjMESMpHh/SpYUJlhEWReTrrw8obsNuEzDhw8dnnKk/
	 FsHbsI43FfGEvvydbDc3NryeKcJhaABs+EV8oLzY+iDUnXsiu0dSZ8OiBzhXH3I1e/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=5TfgGwSvpWd3UKEyFfVSx8qLB6KqQDyrVVkNkIiwI9k=;
	b=1A5FmBfOMbNaUBS1p0qY0PII860t7FqQvmLRRwJZSsBZGuYG5/g0ok6+Tk3sTA/mkdU3
	 aa5miUB5wznM/JqvRMznUG3HHY0hsNE+yLY7s9VUo5L/ihrfu/bQkAtNbU9lxCJ0tdYS5
	 eYfx7EYXfrD0thTGxQJlON2NFemik9DFLmHaZPK3QyxkbuJNr1N+bNwlTfVKet7l+AUgo
	 RJSWpCsq804yIeiH2nflpu7gT+xNLJC6vz+k+2e/5zyJ2KhBO2jKTJeLkFGmpfYM0eDbZ
	 1pUYrsohVb21NSlmW3jOfhjsz6vNea1k/uY4X8ApDFycyhYPHh3btJFokPTPbyNN6Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M2GHqvF7;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388BB606A32D
	for <linux-watchdog@vger.kernel.org>; Sat, 14 Nov 2026 18:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 388BB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M2GHqvF7
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso12307675ad.0
        for <linux-watchdog@vger.kernel.org>; Sat, 14 Nov 2026 10:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794681806; x=1795286606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5TfgGwSvpWd3UKEyFfVSx8qLB6KqQDyrVVkNkIiwI9k=;
        b=M2GHqvF724wS0kGiBHtx8IMO9pTfsh87vMMtqrh0TRHh53vXAGtSa6FsoFW83dLeV2
         un9/GzDNYTMNeNa9ffERXaSfmRfXOo/Un4ca0Rgqo4MQep/6R5F3PxNbkc/BfTXC1eJ1
         72BJBfR8k51ReNpQmJ+Ht24l+iVo3gyF/YKDRl5C6vKWLKOiLfzOdCQa+5a9QOlFlSEB
         rzSeQIUV/ZsOp7QU+s9e+fcHGxJmr5LjP8oW6/JimEV2zwWVHU2nV/sDyutx+szaqZyK
         QVxygWK/FbebtiJYQYDwQuEpkXJT+Uf3tqGkTYhBN8Apz0GwgbFqdVZKVE6RAQttshvi
         RWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794681806; x=1795286606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5TfgGwSvpWd3UKEyFfVSx8qLB6KqQDyrVVkNkIiwI9k=;
        b=mbii2G0E8HUSjjnHJHD2mQWKQTTrYYEWEVWuax1mjPSByuEBoTfZdIWJyeziOu5gHp
         0Qice4DBZPTo5hoY1NyYYHFO9W3EtIFKwZkCkiGNoS+LEvDs246oErsRb+p7aRhOGvcG
         GPHS27gub8v3vrwl1TorYT73yX8W1AOBxyv690sGSBy9JCi90n+P6+EybSzuJLAz6y7Z
         kDQlLbFyDGCV4xJgqzOL+b6OafqRhuBzDdfFtzqWm1aGoDiJpJrMqG+THKQ72yyy2BE1
         XvjIKMwCHtmX9fOtOsRXQpyXa+5XuWtRYb3vPUQoIrJznqGR7DseHz+/QRTjNqm26uLm
         NUAA==
X-Gm-Message-State: APuU4Z+YY19by5KawtL8gP2CaS/7mmBMitpeC9lSE+CAqmVoaAxhx0U6
	D+UfQsSQIlES4YzAC6prge2oLi3/XIIChRKn2Ju31oanLUTMt7TvYRCgtYu+Zw==
X-Gm-Gg: AYBFou3HPROPHixHKWK71wcTQ3oBS5TNC2UPI97D46LvNUV6OVJcFs2l3JJnK60/12r
	Afd9wq0pmCFxyG4hWQ3B9/06/VzMUHTBfN9OFtOsMnaxkd2Fuyu6bG14il2m1smrfvHwWNl95vE
	pPQZS6hgaeB0FKSjBE5eLZV1aLbUSMUjqejcvEE2fnOYaTz8nRPMkGMwEvuTwGgdZjEnus7QUk2
	ioRWzDNYtrI/mJzXEDTdqeiAVI+QixurcR9e9ESF7BU2odApcqVDVv/TuUL17Q6m8OD4aZRr3Pl
	+wn3JduZ6UvZ1r0OAbrCZX3skQtyKgRL02muTMHEIXqEQmOeaOg4DVghtxFam8Qf9lCnDPLZFzG
	qsk/ImzResQidcx4CWxMFg/QAaXcy0enWQbKXD2DElICCdHHxHHDOfTQIgNs/KyvyWlNLSrdbv9
	G3hTgi6S4LQLQJLECUC4Fp0s5mhl4YfEeiS/zX2YSEQy6PJfBKXLDgXTA2UfhHoCWKrWuziiAv5
	MfO7pa92FCXj/N9dnlbV0MDDXhhjmnGHp+BSsebgHAqXE6Dam9KEpTOgs+DNn402JxMrdUVxA2d
	cFJ8VM7yDpzJbTcDX7U7Gb5tUjvsk6zzMPrPIeeI56XJUA++Xhn1ATVUtlz4mw4qWmjN94hnafg
	=
X-Received: by 2002:a17:90b:4c10:b0:3ac:9e76:aa9b with SMTP id 98e67ed59e1d1-3b1b07fee23mr6296426a91.7.1794681806420;
        Sat, 14 Nov 2026 10:43:26 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:6e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb17853sm9700940a91.5.2026.11.14.10.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 10:43:25 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: watchdog: arm,sp805: reference the PrimeCell binding
Date: Sun, 15 Nov 2026 02:42:33 +0800
Message-ID: <20261114184257.535546-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Unlike the other PrimeCell bindings, the binding ends in
unevaluatedProperties: false without referencing
/schemas/arm/primecell.yaml#, so arm,primecell-periphid is not an
evaluated property on an arm,sp805 node. Two nodes in the tree carry
that property regardless -- watchdog@a2c000 in hisi-x5hd2.dtsi and
watchdog@8000 in mps2.dtsi.

`make CHECK_DTBS=y`:

  watchdog@a2c000 (arm,sp805): Unevaluated properties are not allowed
  ('arm,primecell-periphid' was unexpected)

Add the reference so the property becomes evaluable; both nodes then
validate.

Fixes: 73d3e43f9813 ("dt-bindings: watchdog: sp-805: Convert to Json-schema")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/arm,sp805.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/arm,sp805.yaml b/Documentation/devicetree/bindings/watchdog/arm,sp805.yaml
index bd7c09ed1938..690456839fcc 100644
--- a/Documentation/devicetree/bindings/watchdog/arm,sp805.yaml
+++ b/Documentation/devicetree/bindings/watchdog/arm,sp805.yaml
@@ -16,6 +16,7 @@ description: |+
 
 allOf:
   - $ref: /schemas/watchdog/watchdog.yaml#
+  - $ref: /schemas/arm/primecell.yaml#
 
 # Need a custom select here or 'arm,primecell' will match on lots of nodes
 select:
-- 
2.53.0

