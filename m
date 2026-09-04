Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EF64248BB
	for <linux-watchdog@vger.kernel.org>; Fri,  4 Sep 2026 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788552239; cv=none; b=aAhuKebPCi9o78fGvSKhmIG4uGBoBtQbOT7EPLuzf3EALQTKq1zi0CQ0bSmQJ8Nv1cdxAg7sxvZ3HRRaJzbGEfVqeqpgHUDfMww9tGZFA/r5134PzOntgV35WSZE59R0S6IVcYtwN5XHR/i8hX0q9zBXk/i/sW2hitlQ0sshwqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788552239; c=relaxed/simple;
	bh=B3mbXGgcUMU41mdHor14hlewxI1TjYBtrggKnKgV6iQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NS9EyX8rJClZmjeNBEgX/HuOWSzqaSjwL0BQRFoO2o2ocu6pHbmCOh9Q2Vn+pdq5a7jWtLB5YNbrCRleLJO4AMEid8NWVtfNwQbrkLYkQ41EaAImfYcm/2+zMuvCOq/Z8Kbt1c0mI5ZqgFSg9oF5EA7PZ4kHzuOM2xGu2W2cNXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JIAPa00m; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPTQGRuu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIAPa00m";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPTQGRuu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788552237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=B3mbXGgcUMU41mdHor14hlewxI1TjYBtrggKnKgV6iQ=;
	b=JIAPa00mY/0ppMEDicq4da2la9nupjP2QC1w1ZrrLkX8whMONj+el2faYOkvvz2pNNUwTa
	1wD+yJ6Ueuq3PFwTkulb/3rLpOMemNAX5EUtiyLdtS5Qn8dkjfp7ny8FUjLX1lkpTcsFUB
	hOBf5KM1A+mtm2MGISjR16TDs9wuoE4=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-p4VKcuoHMQWQzWUHqw4iAA-1; Fri, 04 Sep 2026 16:03:55 -0400
X-MC-Unique: p4VKcuoHMQWQzWUHqw4iAA-1
X-Mimecast-MFC-AGG-ID: p4VKcuoHMQWQzWUHqw4iAA_1788552235
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-836c8fc09cfso34087987b3.1
        for <linux-watchdog@vger.kernel.org>; Fri, 04 Sep 2026 13:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788552235; x=1789157035; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B3mbXGgcUMU41mdHor14hlewxI1TjYBtrggKnKgV6iQ=;
        b=DPTQGRuuS6E09U939kPQLdBqTaMvNljGVS8TJxuyc+8q77kzvGvORViUb1yVqjI0oZ
         ZoW5waZ1DdvqFexnpll0n+N1UTJXpUVRWiDtZSTShZKxkhl0f8q/LrCdoJWA3ndLPZMl
         jWFXWMCw27H4JayLKj9Ss6UwbvPScyKdrwIcKD657e5BBM2Oe3OrwKjRprwY9OCps/2u
         dHScQl1iQ171j8cJzmOuSBv++Ad1Xhs/cAolHnfMUwSo0qPT6FB1AuF6/pVZYmlXbquH
         QYP8DwgelZt+2AsT6FbdwNzumOHikdAjG4MwU773n8Uib6pvXRapdxFFEfrvomzSLVLd
         3uWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788552235; x=1789157035;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B3mbXGgcUMU41mdHor14hlewxI1TjYBtrggKnKgV6iQ=;
        b=Y0R2AqHtRFLJgFMminJE6PrpIW7TtH6dXNXxEj/woI6MbwO7Yk3ygd7zDCqK5oiZ1P
         Dug/IJOGO/pXnFZweuxeG3fVs+t+KESUroZCHdB+SO3kpOwu6AwWEaXFC/vlCXoZvKeY
         YC065d6SeuLMKpYX93RZegqfG7lyXk9fuEh0QRxQXks2PMVmbX9NDuVlu9P84wEvdHK0
         oIuQFcm1EkQ5NyoJOfKEYiSY3dxeP1DGDOtQwr1tQw61Ohai2FfF66N+3xygu2gv5Bl9
         rShV1UvtUEAhypJaGHtDrpOHFpsXyZIk5FrJmy41xFNF1HaZU02DqPXcRg4z+iloUVyc
         wpMw==
X-Forwarded-Encrypted: i=1; AKwUvBwYYdVMqJPe7RtvRlA09kKVcrvkfoYIESLh/tIp7LnvwI0eYXmnhDXzDlZWfEdeoFR/ywXSHZqYgG4HDWwmBQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mvbBSroMehTbuA5lfRu4Xi4+tvkI6Pc+c3meW8guth6nlDMobf
	IM+JpPPweWf8AnNCVTosnEjttiaS01mRQ8M07t51UaufwdalnZGCSPfmSLp/e0YXx8IYdZIgJQB
	HCPTR6EUORvAF6/+02gYXL+0XDsLEU4VzfNB1ZaDElvL0kqTaKTyTLiZSrN7GZ/cfhQKQ
X-Gm-Gg: AYBFou3XBh8D4YAUfWbQYrunaxFvSmsvjCAG9xXwb9kc0qTfsP3H9mToZJrb+T86k2Y
	KtC7y/9CNVG22qZksnlxvrIYkO28fSuBK46Obt1wt3GPFp4+/C5lyeDs6428nlaxgEdvMUNEdhR
	z/pOM0Sz2L0JnhShxt13jIcHKW6ZmEFHiBsDNJcDLxkAldiZnzoC2kFXL6lJ+t6ejnn5EUWml1c
	6iZO2LryeQmsGPlDTT2stmJhk6iXge+0yzRa8m7goweaLvt2SklyEcWZlv7fwi8occGURuRm9fy
	0No9LEobZfxW+erQIEfNFWjFQg6LmXdSoTDU2qcKlY7atf0w4N0WLPHm9w27fautnan1EkJDrOz
	gv9O0VSYK4eScR1haHLPNUaFk/xjlcW46DQoFt0YiWt/Mk791ih1IkNbA9XiDhNp1K69HyPZ4kk
	11VpOV/ykR5RqiNAK22wjvTA==
X-Received: by 2002:a05:690e:43da:b0:66f:c1bc:4017 with SMTP id 956f58d0204a3-66fc1bc48f8mr902237d50.68.1788552235106;
        Fri, 04 Sep 2026 13:03:55 -0700 (PDT)
X-Received: by 2002:a05:690e:43da:b0:66f:c1bc:4017 with SMTP id 956f58d0204a3-66fc1bc48f8mr902075d50.68.1788552229718;
        Fri, 04 Sep 2026 13:03:49 -0700 (PDT)
Received: from chaithco-thinkpadp16vgen1.rmtusco.csb (184-96-189-144.hlrn.qwest.net. [184.96.189.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040647592sm28398006d6.13.2026.09.04.13.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 13:03:48 -0700 (PDT)
Message-ID: <667d8fa9bf7b0e129cc86c66966a221038d7bc86.camel@redhat.com>
Subject: Re: [PATCH] watchdog: Differentiate scenarios when watchdog is
 closed
From: "chaithco@redhat.com" <chaithco@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 04 Sep 2026 14:03:46 -0600
In-Reply-To: <1c15e728-cafc-43c3-87d8-981a2682d441@roeck-us.net>
References: <20260901214251.760184-1-chaithco@redhat.com>
	 <1c15e728-cafc-43c3-87d8-981a2682d441@roeck-us.net>
Autocrypt: addr=chaithco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEapCVehYJKwYBBAHaRw8BAQdAORXHCioh8sg4JScf3G8JrmX1nUt+teTWsqlbk67dr
 va0NkNoYXJsZXMgSGFpdGhjb2NrIChXb3JrIEdQRyBLZXkpIDxjaGFpdGhjb0ByZWRoYXQuY29tPo
 iTBBMWCgA7FiEEoln/+dhdP2hiiZGQ86/NNaAhFjYFAmqQlXoCGwMFCwkIBwICIgIGFQoJCAsCBBY
 CAwECHgcCF4AACgkQ86/NNaAhFjbm1gEA9t0Iaxr6IkGONOjD7eB10PjTYyDGVd4QdJYPohP8xRsA
 /0OETJIGSr5rxRqG23AGUdlnUfzFlgm3QuyfNpGHcv0C
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-WByAc/hJFcOuzza19si6"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-WByAc/hJFcOuzza19si6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-09-01 at 16:02 -0700, Guenter Roeck wrote:
>=20
> Applied, but please version your patches in the future.
>=20
Ah thank you so much for the feedback! I am a fair bit newer to
contributing upstream; I presumed (erroneously) adding the versioning
after --- was sufficient. I will make sure to add the version number to
the commit message in the future as well!

--=-WByAc/hJFcOuzza19si6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSiWf/52F0/aGKJkZDzr801oCEWNgUCapskIgAKCRDzr801oCEW
Nsx+AQD5YpCe/jGsd9liJwhzqeCLgrsPtjkX9wSLiUmJxrsYGwEAzljO0vv89nGP
eB8SPwY6hunIwWvi31fIccz/45cFrwc=
=ynrZ
-----END PGP SIGNATURE-----

--=-WByAc/hJFcOuzza19si6--

