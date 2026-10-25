Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.36.163.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792954526;
	b=dop5TlHFMfjXddQLKKW6w2SnfxWKzHePgJtpt7IPbGzSi8GMa2BFXWnZ9+mtJABo8tkQ
	 Em4LUPOVXRZvYTBFfNPKp39g7IBGIOCRha7MtNPqp+3wK/yOj9gR8v5Efy9Snvxb8nlCg
	 kMAK+FHIC4B6cmnZcqhch4qrMoR1WNffGLs53pk1VPEJ1wQNgE/YP1ix/gnRVDLgcCqnb
	 hScuMfyNIv2VHs0N0EBfaAVmnxtUFvy8iFtt7smZVbprF/p2S+/1eR5o7QfU7yeW4xgLy
	 4yS4mtejWgzqcZzX0G2olXak9T2YOYitz1KPcoJ9ei7gHiIyGtp6VGVYZnbR0KGLZtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792954526;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-SEG-SpamProfiler-Analysis:
	 X-SEG-SpamProfiler-Score;
	bh=EkyTLH9O2VFlugHBZrm1Y4nRaa319co6IyajjDX9P+A=;
	b=IpRLpYxXzm2+wmPtgoL0MsrKGSYi1ck/u/5M11VzxyPj6KGUvZ5bjGNv1iwzZV9cxqub
	 BlgCXgOB0yUfiGOzsz7ZR0zRO2/DUn8OBz7bs8cMugDvp6qacvvjsKFmANpBUHZa6jyHh
	 o9qvL83igT68LBGz2FQCjWADFtcuiwO8zdKnnqjJ+INvCznrcsgmtduATaaQPk8ZvSVci
	 4F96GFmd+/gIkUkex6ybNY/8KpKYHUOAtM4Yn0bWS25VVAepj8X0p8hZY4poTk4ONXiY4
	 h4b/o5yCTsOqmv9dXiWt6Q1MB3UwWI+KFg0GU6HWB2GHjtxldfuLOBvcPnQMseYgO4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alliedtelesis.co.nz;
	spf=pass smtp.mailfrom=alliedtelesis.co.nz;
	dkim=pass header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.a=rsa-sha256 header.s=mail181024 header.b=fuvEbl4E;
	arc=none smtp.remote-ip=202.36.163.20
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E8C606A31B
	for <linux-watchdog@vger.kernel.org>; Sun, 25 Oct 2026 18:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7E8C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.a=rsa-sha256 header.s=mail181024 header.b=fuvEbl4E
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 698602C041D;
	Mon, 26 Oct 2026 07:55:16 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1792954516;
	bh=EkyTLH9O2VFlugHBZrm1Y4nRaa319co6IyajjDX9P+A=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=fuvEbl4EKTLelfgrg5rBfeeLx3FWULqW+UtemjtlA3KYDErakqlcU7H2qf3S091/I
	 foIX959VV7a1AJnZLKhtxAzpVHyw0PQ0W/Hj9zUEWPfizOAiyqBEfUm4YDOfcyaTnU
	 5p/PujIIrzyQMRhmYG3c/2+PaEkxDMvsyL5eBY3rafY0CYSAj0Vskoz7Bck/7KNleY
	 brY6l8Wu5Ot1IWiXuE112hOAt2t2d9+VlZG84R5/GQItM/v7DKfKQpHPQzPTFE6T/7
	 m0WRlVlcJCfDZ00YkuZisFIop1OT8zWQbeOLGZRSn7u2NyoFqDIs8BBhCBX5qhzNYv
	 IY1oRidHFPHDQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6ade50940001>; Mon, 26 Oct 2026 07:55:16 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 26 Oct 2026 07:55:03 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.2562.053; Mon, 26 Oct 2026 07:55:03 +1300
From: Carl Smith <Carl.Smith@alliedtelesis.co.nz>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
	<linux@roeck-us.net>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
Subject: Re: [PATCH] watchdog: octeon-wdt: Add a panic_on_timeout parameter
Thread-Topic: [PATCH] watchdog: octeon-wdt: Add a panic_on_timeout parameter
Thread-Index: AQHdYyLqlyPOp/BBjUy/2OPLTlmRs7cKrBOAgAPuoyw=
Date: Sun, 25 Oct 2026 18:55:03 +0000
Message-ID: <9f6fb41b5af14c09818980273307e2ca@alliedtelesis.co.nz>
References: <20261023191530.327734-1-carl.smith@alliedtelesis.co.nz>,<sashiko-outbox-183127@kernel.org>
In-Reply-To: <sashiko-outbox-183127@kernel.org>
Accept-Language: en-NZ, en-US
Content-Language: en-NZ
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=FJW4xPos c=1 sm=1 tr=0 ts=6ade5094 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10 a=eOYEQobSZ2qJzmjsaD4A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-SEG-SpamProfiler-Score: 0

> Should the new panic_on_timeout parameter in drivers/watchdog/octeon-wdt-=
main.c
> also be documented in Documentation/admin-guide/kernel-parameters.txt (an=
d
> Documentation/watchdog/watchdog-parameters.rst)?

kernel-parameters.txt does not list per-driver watchdog parameters; none
of the watchdog drivers have entries there, including softdog's
soft_panic.

watchdog-parameters.rst has no section for octeon-wdt at all, so its
existing heartbeat, nowayout and disable parameters are not documented
either. I can add an octeon_wdt section there covering all four
parameters, either in a v2 of this patch or as a separate patch,
whichever you prefer.
 =20
Carl=
