Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7F436B93F
	for <linux-watchdog@vger.kernel.org>; Tue, 11 Aug 2026 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458028; cv=pass; b=pDQBi+mJcX8Osdm/m6MHiMngO63IusVlbZYUKAMHmbCPqNJsFlwJb9d6pYYqXGMm2AhWrf3AcznPYIptjwBloZJxBEyrgLJExiNBa58WJ8si2r9tnKxyJ4JwKyOZHtrS/89o4WCnB5GbOXtFGApFuSB7ProCUOJB2aMh+QHihIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458028; c=relaxed/simple;
	bh=td3YrX4BitSFsJcuxTTJfNltqJvU+UzIl6ht+wT0AfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDQJl3VhOrS7SefiHU+Xn6GYj6yObnxvHgnD4uSJkJOjMw/AQgV0HbFn4aUHQwAk00aqISqe0ugYMaT3Lo+c0PddkSZvE1NwcakOifHPTWwveBhuOWPAph/1PObxeLMhWk//dQoHu6m+H75vrtL2fskRgDFV6vOz96MbZWDZRoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgYfJu6v; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgYfJu6v"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c160420289bso345391166b.0
        for <linux-watchdog@vger.kernel.org>; Tue, 11 Aug 2026 07:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786458023; cv=none;
        d=google.com; s=arc-20260327;
        b=KLtpkLqkZdlh41Y8WxRtyU8eqvpfnloEqIeVrjY2Gzk3+z4l05qjGAuTyMfeCi50z5
         s6rn99UV+s2DcfY9l8aJ3ecYb+obON3LJRUE9j3wcaUe67RH1Mr3q5LyYdjINlfIr9f+
         j/JPhhum5o3/cuuswH5ygVFQsmwL1buimf7JSihljzL94dM80CSt8hFVq52GUI5saPiW
         s9rd+jfmVfxjHrp3vGpL8OIagmfP0mUzkWYaQthfVR7Ko7MWmXvuSTWW8GmIxTYuQ11a
         YPuhKn/2H4JQaedlFMsGw518BYdm/oRU8Qw5m85nKar/qcxKcyJRN2u+gVHgcwUgsQP3
         rAHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=td3YrX4BitSFsJcuxTTJfNltqJvU+UzIl6ht+wT0AfE=;
        fh=x0v+BY5nVbLbQhGriYZl8ImrnFZ5bGMURj59DtskiN0=;
        b=bKA1XxFT/adRsjzfYua9HxQibXvkgDjfJ2WxvfhBVB5yMQLPSk4lKjRxz2gVjF+sdy
         nIRx66ceFIQklil1TizjHcMmhuOQo2qC0KQbrkKEdp/SIvl+ldYByS1I6U1O+8vA68I2
         15s7TWUzny+ycnD5N+FD1Rge06dqSua/kZ+l8dOojosFdNsTIRJD/HXL/T7LJtsjcTBO
         42buoqNaxqbUjJGeMmUku28MCjULrQ0W1q5H0Ulh1vRv+/6ITKA7kYxK0o1mTSwtWEGm
         R/BbOskmJltuJK4aH5cP2r+6lEcSMPZO1owW6/d88Ssl3HZ4VUsG6STt7JOwxoPHiGuu
         PZaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786458023; x=1787062823; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=td3YrX4BitSFsJcuxTTJfNltqJvU+UzIl6ht+wT0AfE=;
        b=CgYfJu6vr3wzJheRrf47Ik4TL4t+1upEmp2Aw4sZE7CK4ppJdIvlS5z5E/ChMsTV+l
         ERGuXkB0QbmlZdL3Q2aPxXfnPOYee2RINRpmGaxgjYeMGdqwX540k6Bv0erzLmTDQ9q/
         xzK90FldYIWe4ycbrFdpFbhIKjnLTJKxgqdhktkaWw/khobEiL7G/7gEFRDWths7KZtc
         ehJpZb63eT5Pndj+FMN3cQSJDsf22zIXR5C2uwWGNJd1hT9z6eyG4B7pS86LXbv/y+ni
         gQCHkCBWAqCJOxHvnIqpyMefCFxj2/oTC/2XpsqRuj/AkmzHQy29WyMwYWjcC5DeasXL
         VXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786458023; x=1787062823;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=td3YrX4BitSFsJcuxTTJfNltqJvU+UzIl6ht+wT0AfE=;
        b=Fz3+XxAPFina1qBnMCK/7rafs2J3m8EidoJ1PM07DBD2mIlAKo84FJa05cwFoHo3Q7
         BPlHvHAu8ABFLkI5o5Zba0sqV5HR/YUBtTN4uImFTNgAeWUeXJJwGFSK4rboG4RFLOUR
         6NFSZNwswRb6nBKOevwWumq3y4wRXGQPrxXBUWu50z80n+pjmeh16EgBtIbmw+nKSbBC
         R5YwgFAfhvscEw9MXmFlFtO3oLzigbpTqPNkfZo09CW2EWNH6GeMP7GRAmLqwMb636T5
         vvuTgdpqmo78ymOEaWG7uCGJLL+4KYPZRZiIy0WgA5K4y/DUZATr/eEua/hl4LZI31Kv
         VDTw==
X-Forwarded-Encrypted: i=1; AHgh+RoxMgs+qch5RxBYAKi6Fx944fDk7cF6ETQ+yq9PezION3hPYv7skmp5bC1EmWG9d35/iADdspKzRd+8h03Mrg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Pwml4I2zT3MEDlttGQwQXVFyQBS8Y0T1ywdxKfhsPXg9CrPf
	kvP1odssAmkYv2gG3QOh76wB8oOkHyEYNeZ6yx0B2Rdc6PdRVriEpQC4Yxozo70Snz4JzvU7Os/
	+JKC8BRBif8nIxer4ZIStKWLPbmHEDonzaH2HzX8=
X-Gm-Gg: AR+sD10qfwfxnS/9ikOB3hfjTExVHAEsJh+OLrM4CicB8SFWnEVoe0Y695DjMYCI4yu
	l0Mbbs1KMASw+xsU8cXXhmnkepIVHx59OUCflXu0IiAMDbJINpCk4n3GQpKcDNcfiyV7Sr0wjpv
	afyG4vS8o9Kg/E3BlLA11116y8M2hebbmHahnzQDxX9SpLfp0PZrXuY+LSZASk0IuRutmtMnzoL
	DZ4BrK18ygKLVUXN4TYWNpmhxY3Xh40HZ+l8dNkq9RyKMHYnagqrTlnndofFPDc1Cy4UPSlPVfp
	IFVeycCBgqOYCB7Tm28yx6ejAywMBzqtGKtj4n3IGdQ=
X-Received: by 2002:a17:907:3d11:b0:c15:d4f8:dade with SMTP id
 a640c23a62f3a-c20ec8ee1e6mr50072366b.2.1786458022732; Tue, 11 Aug 2026
 07:20:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809160643.33991-1-l.scorcia@gmail.com> <20260809160643.33991-2-l.scorcia@gmail.com>
 <20260811-amethyst-seriema-of-gallantry-ca9c7f@quoll>
In-Reply-To: <20260811-amethyst-seriema-of-gallantry-ca9c7f@quoll>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Tue, 11 Aug 2026 16:20:11 +0200
X-Gm-Features: AUfX_mzTu9IARagHp5y3Lhufa5MQ0ahYW_Bpy7_ilNA0FNARMUxNWXd9eRk54e0
Message-ID: <CAORyz2KXJf4gU46649w1ncb7TAOErdoGmfOMzwKr8b+eGdAgVA@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: reset: Add mt6589 toprgu reset IDs
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello Krzystof,
thank you for your patience, I really appreciate it.
I think that a lot of my confusion comes from the fact that I'm trying
to follow the structure that is already upstream, but the whole driver
and bindings could probably be refactored in a more straightforward
way.

> So binding already has reset-cells or not?

The watchdog binding at mediatek,mtk-wdt.yaml [1] already declares the
reset-cells property (optional).
Inside this document the various SoC compatibles are divided into two
lists - one that falls back onto "mediatek,mt6589-wdt" and another one
of explicitly declared devices.

If I am not grossly mistaken, looking at the mtk_wdt.c [2] driver that
handles all these compatibles there aren't really any different
behaviors between any of those watchdogs/reset generators.
In every one of them the .data object only provides the total number
of reset bits in each SoC toprgu, plus a single "has_swsysrst_en" flag
for mt7988 only.
For mt6589 the number of resets is missing, which means its reset
controller isn't enabled (and therefore it's not enabled in any of the
"compatible" devices). We know that this SoC supports watchdog resets,
so there really is no difference between all the SoCs. Both the total
number of resets and the "has_swsysrst_en" flag could become
properties in the binding document and be added to device trees.

This change would avoid lots of redundant compatibles, but it would
break existing dtbs and I don't see a way to keep compatibility. Maybe
an entire new binding+driver and deprecating the current one...?
Still I'd feel more comfortable hearing the voice of experts before
proceeding in this direction.

> We do not take bits, but identifiers of resets.

Currently the existing mtk_wdt.c driver does not use a reset table
that binds identifiers to bits for any of the existing devices. There
are a bunch of mediatek,mt*.h files under dt-bindings/reset [3] that
point directly to reset bits instead of being indexes.
I can introduce a reset table in the driver, but it would break
existing devices as those bits are referred in device trees and they
are often non-contiguous (e.g. [4]). As before, it could be done by
creating a new driver and deprecating the current one, but maybe I
completely misunderstood your point, in which case I apologize.

Thank you for your help,

[1] https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/watchdog/mediatek%2Cmtk-wdt.yaml
[2] https://github.com/torvalds/linux/blob/master/drivers/watchdog/mtk_wdt.c
[3] https://github.com/torvalds/linux/tree/master/include/dt-bindings/reset
[4] https://github.com/torvalds/linux/blob/master/include/dt-bindings/reset/mt8195-resets.h
--
Luca Leonardo Scorcia
l.scorcia@gmail.com
