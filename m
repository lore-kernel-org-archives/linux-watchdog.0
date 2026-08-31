Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E46369D66
	for <linux-watchdog@vger.kernel.org>; Mon, 31 Aug 2026 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206733; cv=none; b=BHwdYOMIoADXO7NgImEno/tvPEsLOLfSft5p2VuNcISLif32/OLonlP74aJPAU4rF54ZGngWyBAHJl/OhwwTEenCxxL62MchCPY7UK6fBRUdmB4w7OIuesQvBxUAUGrxfwhhgRlPWPONlKsps8NFSqlFSurZnEsafakIKKbI9P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206733; c=relaxed/simple;
	bh=TWhgm+PnpeKo87zklKOvqH4t82IAK2P1IEnz+Uem0L0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G2gImqqn1msrbLc/3a3M4pmd/sfXuqkyOW4Edq4I3R9gVPgPGR5rNe2k6yDXlURu9UHxslOeClwzPktVxf1pnuiHCgfURGMAmoTH8PQHXGVUd0KGFm3QwP/8uliRURkT2jmyUbfL8891X9WBRepyvzGQRpdu75Wpmh3qdVHdvL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aXncy5a7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sRc/AffV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXncy5a7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sRc/AffV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788206730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TWhgm+PnpeKo87zklKOvqH4t82IAK2P1IEnz+Uem0L0=;
	b=aXncy5a7TL3CdBK9TKf44D/kf7S9JfbI59GxOJ8HoZkr36nBOHyco8jGp/1QMJfbMATShU
	U3SdrRcPw8w/jS9widEGvTe3+kYUpuHcMRW6VcGeGt83LPO00rt8edfNGpVb5f8kyJWtq6
	bm/WOiYwCwhYmNibon9fY+hDW8rMEH8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-q3RqbohGPGCPlsHt2LulTQ-1; Mon, 31 Aug 2026 16:05:25 -0400
X-MC-Unique: q3RqbohGPGCPlsHt2LulTQ-1
X-Mimecast-MFC-AGG-ID: q3RqbohGPGCPlsHt2LulTQ_1788206725
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e53b8a302so548014985a.1
        for <linux-watchdog@vger.kernel.org>; Mon, 31 Aug 2026 13:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788206725; x=1788811525; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TWhgm+PnpeKo87zklKOvqH4t82IAK2P1IEnz+Uem0L0=;
        b=sRc/AffVS68yySwV3IKzmXeqRwbWocQsPsqBFyY+KmSKQdA7SY98apZH+RcXJ6e3z+
         N591MQ12B7SduEsz2iUPGMDXBuwsCx/bB/gwdawYI+JCjF0fXWn7s/aUJ+KNtb/nSu/M
         udVVsOrbEhYcRB9WSIKqXkonUqP5hdDejpDUHG7EtAEkDcIBrOqrF3n3UBEbeOmUWnWO
         iRSqwXOWCDgzMk+IRiO0FPQe3SIZITJOFNT5Urj4wcil8s/F2YT7qV9+hHZuGLuR0m6h
         I9KXfKWTW8zVqe0onFTYpEVdLYYaWhJeyNe4N0XsBx3cy9mJcZnUTwCtN8S+y4Pdlqp9
         S85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788206725; x=1788811525;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TWhgm+PnpeKo87zklKOvqH4t82IAK2P1IEnz+Uem0L0=;
        b=Z4oCB/WZpYg3tMbHBQoZyfnmHlfWPN66YHhU3WVhnyo5BgmQnW+00jfHXCq37WwgMe
         tNVlR/KhcWCTvdZnd0oRW3J6dd1tULFTZiJrPZmH6URLJrEtmYCXoSjLKkhguzcEvhFu
         7sIsvE1sU/x+m9OsNDYnNyZrmxguWYx92VNctUtdjOruvF2Ps+lc7a/55x3iTM9gPZzR
         SMAj1fN6uKAemMAuQjqqPF4FVJ9ylrO+G6QwJTrkqHFfds1o3T92sjF8lwcJPQ5ccMgI
         gZRjeusxw1qXGPoRXtR50A4qhK6ZGUuSPtGaG7xWSplse8jgrOQY8tWVf4SCW6ZMZXuV
         az5w==
X-Forwarded-Encrypted: i=1; AHgh+Ro9N5toWAceaFSVueATPQgyGHNdsIlsZn3wf5lBPHp9Y+iYCZQcRR9g0+U8Y55Sa0ZfHIZjhDiD4D6HOxGRjQ==@vger.kernel.org
X-Gm-Message-State: AFuF++l1ysVB7x7UwX4hEwFo6viU1Uhrgb+PUywUGBht78NGWqUSoaDx
	o0itEk1D6UIlimJPrlimtCtqjSUOytq/06QGoR9fQaUmpR9ezxgbw6ncV0mLstCQFFXbSat+ILw
	6V+R5uJ47/ZVFX/00Fej+6ivXRy4R+Tbx6IJmXotSDMLOAE1Pt9+YY4/eJ3gwz+PpACDMo6TiN3
	RB
X-Gm-Gg: AR+sD1182tu7N8unWOxpCxeCoCc4qGax2lOn2eh4eA7yjGS625le8T9iWa8qNZ296uR
	K+cyeRY+bN6xi4umZVaWl9ma5cmmqMuu0Z1LXD0Pbpxq9GNZrj2vi8WL/iTRLnKj0LZRK4z9q3j
	+ghJnHF6z94ZBpM653UlyXCq1KwyuqRJ8sB+7ZlRkR0a39SzXxu4A5SHnNTX/J1KZCzUw7leQIQ
	915csDeM03jb9A8E2mHQRN7CB5IGdgmc5xUBQbhHOmQl3eLdXbuXDzP6oA7eBBvl/64wucXKLWU
	7IaYLKJeC6WUNmlk71/EZLBdOoe2dRiv0OFDRtAbSYqrzrnazzycEgK9Iwdd3lQ1a+bff6nIlSk
	oQXcMNyh9oYfCCu6r1t0+Ms0GembGiynFL1cXn2XBVBA3/88Y6r/LRgcd9N9tegu3aeZzP0POHC
	glRVPQRnFe9fguDClSuw7o
X-Received: by 2002:a05:620a:29cd:b0:915:a953:4b9c with SMTP id af79cd13be357-93913749780mr3027248185a.3.1788206724809;
        Mon, 31 Aug 2026 13:05:24 -0700 (PDT)
X-Received: by 2002:a05:620a:29cd:b0:915:a953:4b9c with SMTP id af79cd13be357-93913749780mr3027229785a.3.1788206723665;
        Mon, 31 Aug 2026 13:05:23 -0700 (PDT)
Received: from chaithco-thinkpadp16vgen1.rmtusco.csb (184-96-189-144.hlrn.qwest.net. [184.96.189.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9391703a49asm865069785a.11.2026.08.31.13.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 13:05:22 -0700 (PDT)
Message-ID: <df49394b45f04e0de5ab0300a8d18f5ba6d38b01.camel@redhat.com>
Subject: Re: [PATCH] Differentiate scenarios when watchdog is closed
From: "chaithco@redhat.com" <chaithco@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 31 Aug 2026 14:05:20 -0600
In-Reply-To: <93d22742-bf3e-4e69-aed5-27137d8f49bf@roeck-us.net>
References: <20260824205051.4117285-2-chaithco@redhat.com>
	 <2bd566ca-2696-46d3-aeec-57db66fa1902@roeck-us.net>
	 <QBUFKT.6XP2A9BR6LRO3@redhat.com>
	 <93d22742-bf3e-4e69-aed5-27137d8f49bf@roeck-us.net>
Autocrypt: addr=chaithco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEapCVehYJKwYBBAHaRw8BAQdAORXHCioh8sg4JScf3G8JrmX1nUt+teTWsqlbk67dr
 va0NkNoYXJsZXMgSGFpdGhjb2NrIChXb3JrIEdQRyBLZXkpIDxjaGFpdGhjb0ByZWRoYXQuY29tPo
 iTBBMWCgA7FiEEoln/+dhdP2hiiZGQ86/NNaAhFjYFAmqQlXoCGwMFCwkIBwICIgIGFQoJCAsCBBY
 CAwECHgcCF4AACgkQ86/NNaAhFjbm1gEA9t0Iaxr6IkGONOjD7eB10PjTYyDGVd4QdJYPohP8xRsA
 /0OETJIGSr5rxRqG23AGUdlnUfzFlgm3QuyfNpGHcv0C
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-0ywmMAk0QA94DymszmK7"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-0ywmMAk0QA94DymszmK7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-08-27 at 11:10 -0700, Guenter Roeck wrote:
> Problem is that we don't know if "something bad happened". The same
> message
> will be seen if the watchdog daemon was killed or crashed. We can not
> just
> assume that closing the watchdog device was intentional.

That's the same sticking point I've come across. Differentiating
between positive intentional closure versus malicious or buggy closure
would somehow need to be communicated to the kernel. It makes more
sense that users of the watchdog which intend to close the watchdog
while still running maybe denote such. I opened a PR with systemd at
https://github.com/systemd/systemd/pull/43552 to see if there was some
way this could be tackled from that perspective.

--=-0ywmMAk0QA94DymszmK7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSiWf/52F0/aGKJkZDzr801oCEWNgUCapXegAAKCRDzr801oCEW
NtczAQDuBs40A1K1EQdOhomprxd8gwJPgKlHd6zb+N5UZpMywwEAmTSigALQTDZQ
Xi/e4vWX8AfozunR2RkF1Sz08H1EYwY=
=AKZI
-----END PGP SIGNATURE-----

--=-0ywmMAk0QA94DymszmK7--

