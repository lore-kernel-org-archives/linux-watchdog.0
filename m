Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324503DA5D7
	for <linux-watchdog@vger.kernel.org>; Thu,  7 May 2026 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778153646; cv=pass; b=AfYcVHOoiKc+qGlEYtRnSU5TAC4QDUY46YVX5fWwZAZTv42dixYmOScVjklrQZQ66nwlGZ1HULDOTxuHGpPfEJXBH9S5+e6xVf/V52W2028GwQviQNbPiZfIo/oApZG25y88LShCfDGvzh33iPsEjrkQUiXfZ+XOPjuPg5AOJ8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778153646; c=relaxed/simple;
	bh=Q20QDhJ+CkHOOmRsGydUBGFCEJTPn38DBqlv7TfBNIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B16qfbIg+UhQpoibzD3GMhAhYEhF4vrUoBDnwMgro89nZUDsujkhCh731y3vMiImfLH2VShrR2BbMUm3co+ZCg1chB4BFKrB2khuRN+j1CFe9K3UIt3vMv9i54INp1FRec9ATQcZzt2EXKmXY3724S1YByOKycL+ISP92gW2svs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z280gHwi; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z280gHwi"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a865d1547aso1835413e87.1
        for <linux-watchdog@vger.kernel.org>; Thu, 07 May 2026 04:34:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778153643; cv=none;
        d=google.com; s=arc-20240605;
        b=Pv2c/sOA4RdBZA2j8JEY9Dvq+AskloXHFvTYpcoFWrM2/y31sqEZO1yHc0YoY3x0GY
         HZKvHsWB8DverCGKQ9ZJx9Igh8smUqACwIAZ1nreLL5lVmZyME90LwXAW6c9XFmb/l8w
         cPsvCxjSN/oOAHK3ZHzXKL3e8SQLr8o5gVWvcXxM3TGKAr5BM/pi0n1/cr9imxClO02L
         69UETtUCwHpKxwP+6VG1Pa08saMdwVo4fRKRKBCdk0f5cIVJGryXWlRoWStzMIsFgYfC
         9PjeZ9RPfnATdNHb77t5bidrlKzC5L81jD2deCz/pnkKQacKGMAhMznDB8SQY5oDXuv1
         QSKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kp9wAzzJsJF4EUW0K6lSQvm+ZX1IeOPyDmz+JSnwJb8=;
        fh=4hB6Ti55ogs5QVEWUidQfHGSkxw3DQoVEt6i4clHC6U=;
        b=SWX47Q6VjEX9IGzmoihM6ldypIg3dpA9WVQns20tRjlmmR/N2Yz8qMHH+mU8jnwJX5
         ovtU6gDscgTrvLIAy9o4zc85Xt5f1q1nW9WwQmLxcLMwo9B+2cmTdHp7JV8og7eP9doL
         Q8dvmcZdXF+0SW2WLmJ7eRcUsoyaXuVySc6iHy/YvQaClBg4I7J9o5zeoEytwYQs/eiP
         LpKU8TN6SJgkRy3KGQNDIjYFiVJVu7Ge17u+HZCCOeKyx0M+0Ie7kNzXA+fcJzBbmthc
         4DQYFiX4exkN1ODg2cHdC1rvUzB1Jy0QNBYCSyZkBqGtp4fqk/TfHHfZ+Zk73s0/jXSK
         vSFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778153643; x=1778758443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kp9wAzzJsJF4EUW0K6lSQvm+ZX1IeOPyDmz+JSnwJb8=;
        b=Z280gHwiMQeIfxgXfdbm3KzFsyii7PVx9IiQSvFeNVzrKWvnPpwE/tIZLAg+vnJPL8
         o/303ol1ueKyLnAeRQ7rIYTAqizavrjaY9BMV6OstJs4cC3FToBkT7Xpfkl+Nd3kY142
         962n/NeVkDLCawR3O3drXwFeuLjvH4p2DvRKpsKSYjRIKb4nt5yCsqSnrdXTtmelwxoA
         1Jqz89uixB0zSMAqXoo+1GQdJ9+lprzSJJyEkRF1OolvIVN3C0yxKL1THvP9dmLsPmRf
         zwOZsjSp/iqaHzoubXJsGkUSsBLgYqEgurXjxUxJwJ1kOIGcMlMATbPEkAJEPuqckogD
         xv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778153643; x=1778758443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kp9wAzzJsJF4EUW0K6lSQvm+ZX1IeOPyDmz+JSnwJb8=;
        b=SPtSkm3t2hSwnB7uqL/NAMdxgP7/5p3lKD7OP/6NW3mItKd6NDiKodWV65F0ktRSqG
         ZcCPS/QKxuZs4/h2lZNQxZOR03gZmMX5HE55MY7FqB6GVuGieWRIG6GCFNUOGNUzMo26
         7AB0iSGYodZWHIGLm7Zngl1bXajbi0ULbCsObpOPjWtf7qbEC4e9BwvIfwuStTDRasl6
         i699SBxxFJqMfKO+gtDNTSjHgMdKxjjBi1okSXc6IvCQRgm78hGFLRlqXST2NNVdhv4E
         jwZ6fdfr8xUn0a3Ovse1vf027jM3qMx62nbitbO2H5I+vp1V8djkW01TB62gQe1upRg2
         opnA==
X-Forwarded-Encrypted: i=1; AFNElJ8wSBuLfgoQqYQ21JKu/2MMoJdVutHM9Z7Uzdzx8YhFR3UyZy/ObeuYDSz2sgOZujmLhieooSaXKNB8A/Inng==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEq0LeQs7JzX8vG5dHAGb09baEs6eHfLGERGTkx6BsWEpmnk0N
	TyUtY6gTKO/xFPaxvddVwWDvTKJ2mSOPHkCy27ypIh+H1UygApxoCWL0Zx4daOrxLFkcajWSCvW
	6h2O151JOKNQFzNJGHSdtL18VA96mKSI=
X-Gm-Gg: AeBDievT1DwYHuarjfbFEXjXdyS7ujt7IkhbrGgsdaij4cNzpdOl8Eq7BPFQWan5Oh/
	9nNRpYXiwC+3qtrD60LqKGDOExOzorBhNjos4LTVxfU/MJB/WGsKX1syy6BcM36Ct5HGRzjrI28
	ufrzFtOqjI/s5N8v2E0VLrjliy1ZEQkAk4hqWi5GiJqIe45Hm/diYoMJhV+X0U4qGcELS04Cl6+
	pQqzkOZdnsdekd68wJ22MgOv4IocYCnR7qP10p4cOnWpIFCAAw/Xd1157tim53DJE+34TwoGLxf
	GVNsbvJwsNv9JBrgQ2O0Op5P5f7oJh3BaKom6g66B17+ezPFswiJ7rPjfiJ64YA5mxkE7KFR22Z
	UDMgK70WY5naANLjrnX1X+TKVLnQy
X-Received: by 2002:a05:6512:114f:b0:5a8:6cd7:3203 with SMTP id
 2adb3069b0e04-5a899b90511mr884078e87.3.1778153638701; Thu, 07 May 2026
 04:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310002040.417424-1-festevam@gmail.com> <CAOMZO5DFWYUPN9sPzBr-W7fy8ZbrXP7u1sx=HrmUAQVCLrsdjQ@mail.gmail.com>
 <066e3058-5ba8-4695-9f45-523c7d43ab76@roeck-us.net> <5466403.V25eIC5XRa@phil>
In-Reply-To: <5466403.V25eIC5XRa@phil>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 7 May 2026 08:33:47 -0300
X-Gm-Features: AVHnY4KXTC7TNhYmV-3I_G0S9oGAnT32r1vGc65wUrsc3DDxUO6SVYL40eT0UMM
Message-ID: <CAOMZO5AqJJVPKPRXGXEZC_b-rbmuV-futX9efKw+wSUGN=R3Dg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: watchdog: rockchip: Add RV1103B compatible
To: Heiko Stuebner <heiko@sntech.de>
Cc: Guenter Roeck <linux@roeck-us.net>, wim@linux-watchdog.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabio Estevam <festevam@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

On Thu, May 7, 2026 at 8:22=E2=80=AFAM Heiko Stuebner <heiko@sntech.de> wro=
te:

> seems to have changed, as it was applied as
>   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.gi=
t/commit/?h=3Dwatchdog-next&id=3D882fc25d868fbd0d71751df4df49c4b55e3fa230
>
> @Fabio, I guess you can send that rv1103b watchdog devicetree
> node now.

Thanks for the heads up.

I'll submit it soon.

Thanks
