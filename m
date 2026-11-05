Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793844807;
	b=drUXfzlYioDdnIDgF8JFQ7n7N5Kgm+1fv67yzlGv0Vh4NaNqHT0pWydysHwAjcOiC1S7
	 jIYTIODZx9RpjlaFH6Q7PX56xdJNDnifFvaxz9pWoG4VAzZTuTW+Z3T/kVsdRcMSxIwAc
	 2wo0Koy08wqvuK9YoVefW6t7ddjoMI3bX7l0jnv208jwODEdhJJfZ5m4NkvnuQqEBtmU4
	 yS1DWVaOf+rivp3UYAIo6RK9g57D2CNEQBeREl4cusuLJiuU2wR5465SPyBCGnjqV5Bi8
	 E2lTL2bAzE04Te/Odx7DoAQpV4iveHyc0aLO6Pnhv6RXmOQFt5l1fO7qYkA/uTl7YrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hpziF86+RxjzNw0Zs0xyBduF0/c5YvcNE86OKRmU6Dc=;
	b=X3AmkG1NWxpO3tzj9wa1KmNeAyYMdUNZMgVg352cdvNk7Z1RVV2KMjUdv5fd04LirRXy
	 RMIHe/Vo8eUivhoBO5CiGc7a8XHPNbN8V0SfGjl9rxl88isy0rs87n5HSjDD9A2OeoyNa
	 sbAEJuBGTEFh+ioYPKdo4qNY9VUfYfU5HnVmn5fBCZx5fEskUNhoBj7RxLxyzF7w0mFzX
	 7RPQCQrOBh1gOeq/Paox/P1/f+WoxARu2DYzQnWuk1qot5Fh82vFLh4ZCCJmqOGQy4uId
	 iDyNBNQix0/VFNsGcK4wy3It5oKF8+YgQWlVJjO1rGrWUS5C6xtBtaASmQUpxPTZnbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=fail header.from=chromium.org;
	spf=pass smtp.mailfrom=google.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F628606A330
	for <linux-watchdog@vger.kernel.org>; Thu,  5 Nov 2026 02:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F628606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b579ed8da6so3060a12.1
        for <linux-watchdog@vger.kernel.org>; Wed, 04 Nov 2026 18:13:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793844806; cv=none;
        d=google.com; s=arc-20260327;
        b=rOFNCUiw8xJsYatpZKPpvo77AEdb4jYqQ96lFUeu7pv+TPkky67xnMc2Md74qCi2c6
         KzyScUhFg+izzWzsSGPtJQo2OJHsFXq7Km4QDX6gGWYrnZtSRUgD4vKmHVgpbDV1916s
         Oi1DIuCZlyRedtBB+DtUA9aoi8I/MWYGkcKCuQ2zBx0SGso0jyluk5h7nIT5TtJoJgP/
         4Y4er7U0mn4mKPLPR1g3ABz/s4sFSKwji1036tTZGwIL/zMU386H35Y/vgmo9qKq7sKx
         3I8I82lO21RbmZHdva0C1mdIw4Bg7ub//c7AMgQEfRr5lyugKJqvbna+QCytHz0ts5Kl
         6++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hpziF86+RxjzNw0Zs0xyBduF0/c5YvcNE86OKRmU6Dc=;
        fh=C9i6K+4QAjV9Pn6DNFPNMcdFzZ5hDAjkcRgczHPapA0=;
        b=PeR6W3rUXaNTJv7oya0gKToQXQqCNAEkx3twdE+8YJSvLePPWKLHmycXXoubNugf9e
         QbXcPpHBGZHReq8rh7u4rOZ9IZ43TjZQK6EYIMePWUxYbtoAav4Ispg6cNRzNn2MjoED
         szgZRBDNnHDWDatCpG4ClxqbmaNIdUTcyRSQeWemKAdGFd2Oyk5jEO1gxyWH4kbXbg6/
         W03+XAjCeqeknE2bcTGkFDtzHg50lD4VWLJumu0pm0dKBLpqnPTbCvbRbOolMSFpTgX0
         xddNrDtpXuWXLPKOR1RPR05dx2Ld0Kb8YRBVcjqprI/penx3CWbCLcF1ClTktxtbnXGy
         gWKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793844806; x=1794449606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hpziF86+RxjzNw0Zs0xyBduF0/c5YvcNE86OKRmU6Dc=;
        b=e54vUMq3VJQg+XBl/xCM483M32/b4tOTj2yEbVLqfjK3dNUY/Mc6rXpZ76/jR2LPQk
         +Wy9VOwrhxjo4L2MnkX2IlFBmLRwbJr2p0RGTnW2JAb5Kj8gHxrNJrzjreEVNyHqXvh8
         8mYGJ1MunF3zziLGlUy8UGiA/Ej/jRtKSK6hM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793844806; x=1794449606;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hpziF86+RxjzNw0Zs0xyBduF0/c5YvcNE86OKRmU6Dc=;
        b=BCRq3d/3NZ+HXba4l7ALM0/8ScGkciyvZVjDt0Ok18GutzFGLgXT89psRnuMbBbLe3
         aYyHiT4p+KiCXR2FenQmIB5JuGdNBAhSVO9VWtZsu5M30mLwq14IQU0MVaousMiu0Cvf
         1LGxgmD+kkxH8p18IQQYdHmvc+4P1qMQZTC8McrFtl15U/Yix2J/8bvi9I1jnWrDBh8U
         P9bCU91Nx43zyClBd1scr/kU7SSMe37kwuxVHuJxhhKrOKDQ05FyssV+LSj2VZKPG6Ym
         geBXUa41dvh4Yi1gcimJPlntSKcVEL2Yag+vIUiuXILD8vkDxjRGeoTpxACWOtA4JxbR
         NINw==
X-Forwarded-Encrypted: i=1; AKwUvByrQO2P6agRmz7/d5giFiQrQhKXE+7Hs9cEaiBNYSUcW3I/8/7BhHQy+3TksVvw4wkvMc9NFtMVfHTRkDMr1g==@vger.kernel.org
X-Gm-Message-State: APuU4Z94ca2FGKuT50QuzCsbxl2VD2kIiVmNu6DZzjCVFx0dwQ9Sv5VQ
	LRUdd4HUdOZAjIGFBjseQWwAAO9KNrO2yVk7/lmnAXMSdiB/uKfzHYQZvFzn7squS9/CcycfASn
	iG427fzyOMTfC0WIow6Ngdm9f1LrWL7ss6XeGHcf3
X-Gm-Gg: AYBFou2e5WE7vwaRJGPMGnl9FBMdMipNdtgikncm1X1Gw7EcQL1w60yrchiAJTfSjJw
	D+Kid2Wh9yxtqjqFHcpTVBSemIJqoLo6TEXnA+tpryHNbtBOIiCCTui9Qr85nL+t+dXtXOV0WBI
	VVTJAMkj44R4slI8Qdbd0OU6of2HsS+WnnqFlUnl/r0S7iRLSsBQ62TgKQwkBne6bMSesBFeq6P
	RmgR8IYJp4xun6c7d5GEv4q3TIHcln6PxFCOjGdS8WFdSWcrJn9JLMg2tEYrEiRe5rZxBdlFv9p
	TWLMn5oF0k4EDkIv9Fkfy8toyeX380QZ1vtLBVJqOeb2DRx5RRvWlosHIAqBm8Dgd5MKoXl0OUx
	96xsUPgUwKTIq3gFxHmMRuCUt609o4qXPbtFCj/XhBfVwz+AogFMVZXNY9cuhtxk2KwjBTpvW5P
	5Iidyi0kiFZuOmjTPBaiKgQA==
X-Received: by 2002:a05:6402:7cf:b0:6b5:65ef:440e with SMTP id
 4fb4d7f45d1cf-6b57cdd26d9mr21493a12.12.1793844805321; Wed, 04 Nov 2026
 18:13:25 -0800 (PST)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104161553.30115-1-mateusz.nowicki@posteo.net>
In-Reply-To: <20261104161553.30115-1-mateusz.nowicki@posteo.net>
From: Julius Werner <jwerner@chromium.org>
Date: Wed, 4 Nov 2026 18:13:12 -0800
X-Gm-Features: AclHuK-125zaIgRXhhjwYItELasBysm9j_wuLFip_xcu42o_jtzCl0wz_NYTSuw
Message-ID: <CAODwPW992ncQNo1yxrOrAKKZ62TB_U1eYWstZuTKDKqFCFGRSA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] watchdog: arm_smc_wdt: allow a list of SMC
 function ids
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	linux-watchdog@vger.kernel.org, Julius Werner <jwerner@chromium.org>, 
	Evan Benn <evanbenn@chromium.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Antonio Borneo <antonio.borneo@foss.st.com>, Marek Vasut <marex@nabladev.com>, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> DT folks, is there a way to keep the list in arm,smc-id that you would
> be fine with?

Perhaps this is a bit of a hack, but you're in an unintended situation
that wasn't supposed to happen to begin with so I feel it might be
appropriate if it avoids adding a whole new mechanism to the driver:
What happens if you simply define two watchdog nodes in your DTS, one
for each SMC ID? Both of them would independently try to probe, one of
them would die from getting an SMC_UNK, and the other would continue
working to pet your watchdog?

This driver started as encoding the SMC ID in the DTS and that kinda
seems to be the standard for drivers interacting with non-standard
SMCs, so I would prefer to stick to that rather than hardcoding IDs in
the C source (if we do that for each board it may end up being a long
list eventually =E2=80=94 I think one of the reasons the device tree was
originally adopted was to avoid things like that). I would be fine
with the array solution but I don't know about the validation checker
and whether people care about reusing the same prop name with
different types. (FWIW, in the device tree a 32-bit integer is
basically a 1-element array anyway, so we might just say it's always
an array and for SCMI only one element is allowed.)
