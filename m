Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B695395254
	for <linux-watchdog@vger.kernel.org>; Tue,  1 Sep 2026 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299078; cv=none; b=AVLZKhdXYOcGgxAY3+rjUIUY8X+K4bFLzNJyPKJBFMJgEvgMsc2LPYD3Ohw9wy4yucJ1nFNg1jERaQFUSF6IrfUIIG7hMJh3ITY6O4hJUSDVpJB/amnHcbVAZZb8TIl2Bygh5VMP4PXoYjCv4264fbfxDU48YcWmCPfAdA57//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299078; c=relaxed/simple;
	bh=78PSisQVDGpcVsi993O+WfbdsKSJIX3iDFdPTCY8354=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CI4LAbwYyWa697MvzTAmw/WrOT0VsnjFaZtcBbkOsJrzdQ5yr+ywj7GLJ2e+OF3l2XiR7ds/cRrc+G50i9J3F9dsclWFVVeM/G8ILQyMSkWkpAawRN6whZTkn/v2/aOiVXPxYReuRJIrJoIBuhx+i8i/8/yAbK4UkdHKmjTDx5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eoHcSXzJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SSQqa4Ab; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoHcSXzJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSQqa4Ab"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788299075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=78PSisQVDGpcVsi993O+WfbdsKSJIX3iDFdPTCY8354=;
	b=eoHcSXzJgB2wRrbtnCs4orSkUwSvYktGM70nrVnfI5cOURyC7JJpqkpX9m1+rJzRlmrTZZ
	O3N5h2rifRXA+i11l9C3ypPlqsOpgatYBJ5AESS5oBzQPmKp+7ABxnDml08825E1sj43/u
	SGY091dlkSsxixBFXwP19xqJj+JKgcI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-cXJHM6ngNeGEEY8hyt4tPQ-1; Tue, 01 Sept 2026 17:44:33 -0400
X-MC-Unique: cXJHM6ngNeGEEY8hyt4tPQ-1
X-Mimecast-MFC-AGG-ID: cXJHM6ngNeGEEY8hyt4tPQ_1788299073
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-530006c6d43so6103621cf.2
        for <linux-watchdog@vger.kernel.org>; Tue, 01 Sep 2026 14:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788299073; x=1788903873; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=78PSisQVDGpcVsi993O+WfbdsKSJIX3iDFdPTCY8354=;
        b=SSQqa4AbIeG6zBnUg1q86Fo73kHRqdTk+oH5mEWJKosoeoOjMustQsM0MvcmB1BLCe
         AXP+FgsTqQ5IAeobguG0Vu2BuG0f0rA9XtIBQ6UjrcPS6ncGJPiY3djE4Qu0V2T3V7gm
         c3fXM2wg24mj72/WPWyDIZUC8liQMlsEeQDhDmek8B8wgYNm+pfME34nWKNagyE6uXZm
         X8pcKTRBjA00BkSsRy08wdOac2ZxR+bmFgCTuzXyahpbnVZIHcm69xvuvrR0khRFHBf6
         nrlPMsneKlzInKIEZBsBJ7y/2eugxYjsTDUOflNjYD3/mEdg7Xq6nx5PvF4IuhOxz+hc
         /yJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788299073; x=1788903873;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=78PSisQVDGpcVsi993O+WfbdsKSJIX3iDFdPTCY8354=;
        b=qKpwXQNeF00r08+BoSjo6K2nX/7a3DQhWoZ/WUcuFM6E4UxqgbmHmDmN+6uWS1C1tA
         XVehaTZuhkzgszbgvBAlkQaFnxJqzeGH431ShjC/5x2T6dGeDnkZmEd6+T71M+grvmKq
         E3PpdorcOpqpqyIFIZGBTbrUGaabdH6tL/3UQrArtDVSTf89h2CaKCH442/4+Y/Rjgy6
         kwsXX1kA0KIPVitVQ3eQrgUZ7jiDWsOkD3tiSwNcAQXT4QZsvQJkkYYnN/cmMC7YNrFR
         QAKozG0goaIwQQc9GdCBhsMOEMkcr7s8NHgDumwc2m7K8OExbxiIAQg/HDs0wKU/gLot
         lfWQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq0o/OMoJN+4BpdO3iubQ/4yvGP/Et8VQphaA3bf3sGP2jfI5x0o9nns/Ji+yhETIeqdrEg1gpYxGEggISAVg==@vger.kernel.org
X-Gm-Message-State: AFuF++ma54uvbPMa5yGu8QJAk45gkLZibByrQ+rSM4TmMydJu+C5HygT
	erqKbES1tVqbKfIQrQGsTdY8/K/Yxa5bzL5Itts31pjrNQ56Uf0eoKed8tT4fBgJ077LmD5wX4w
	kL/gCM5ngZp5b08QTtpJkEetlF9jXqLwIK/b7KJrRSHFbLX2V5KeVtClEFXXmDGPs7cjs
X-Gm-Gg: AR+sD12Mm6cI14jzE/6ZFF6onBkNc1Y3jlomsPxSqUMU+DF259M8AoO7WwGWCvzQ3L8
	RdbtDbj+yEqUwYALKDr/33Hup1Aw8AiafO/2mZhTbWjJLgEX5kHR4mD7yUk8O0OuL7ujDrV6FBC
	mnhbV7fPiNTdOAoCE9h9YQt7CrYME4Lora+24auMVarmJaUibEb8CT2OFqQqVWMQ4wjeCyEpPSt
	jU+OuB79NqrfWHNuT9eW9EqvdAHjuXmOm7/8vMawg/nXqjatPbXWHjX0TfHJS/vEuDI/0Jj7eMu
	N524Ukde7nhfg696xZZzjncFh1ngcAhVyFkplXFtJ99F3UJko09dRXQwU5JI7fp9akPpbEMGklu
	SbaFT46/BA5ZjwZ2itpsXbSz8pnqB+QvMp4KGxKQCJQNRMqVvfNgdoMCQy56ww10mvIw6tmAeMM
	Pyrzt8wh1hmmLDTcM6N55m
X-Received: by 2002:ac8:5913:0:b0:52d:d12c:3eee with SMTP id d75a77b69052e-52fb967f185mr441537021cf.23.1788299072857;
        Tue, 01 Sep 2026 14:44:32 -0700 (PDT)
X-Received: by 2002:ac8:5913:0:b0:52d:d12c:3eee with SMTP id d75a77b69052e-52fb967f185mr441536641cf.23.1788299072362;
        Tue, 01 Sep 2026 14:44:32 -0700 (PDT)
Received: from chaithco-thinkpadp16vgen1.rmtusco.csb (184-96-189-144.hlrn.qwest.net. [184.96.189.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53032ff0dedsm6123891cf.6.2026.09.01.14.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:44:31 -0700 (PDT)
Message-ID: <0004d70b06f8f48215a211b4b49384a0c3e06a3e.camel@redhat.com>
Subject: Re: [PATCH] Differentiate scenarios when watchdog is closed
From: "chaithco@redhat.com" <chaithco@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 01 Sep 2026 15:44:28 -0600
In-Reply-To: <67f191de-fb07-4d2b-aeeb-9bd6514a0068@roeck-us.net>
References: <20260824205051.4117285-2-chaithco@redhat.com>
	 <2bd566ca-2696-46d3-aeec-57db66fa1902@roeck-us.net>
	 <QBUFKT.6XP2A9BR6LRO3@redhat.com>
	 <93d22742-bf3e-4e69-aed5-27137d8f49bf@roeck-us.net>
	 <df49394b45f04e0de5ab0300a8d18f5ba6d38b01.camel@redhat.com>
	 <67f191de-fb07-4d2b-aeeb-9bd6514a0068@roeck-us.net>
Autocrypt: addr=chaithco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEapCVehYJKwYBBAHaRw8BAQdAORXHCioh8sg4JScf3G8JrmX1nUt+teTWsqlbk67dr
 va0NkNoYXJsZXMgSGFpdGhjb2NrIChXb3JrIEdQRyBLZXkpIDxjaGFpdGhjb0ByZWRoYXQuY29tPo
 iTBBMWCgA7FiEEoln/+dhdP2hiiZGQ86/NNaAhFjYFAmqQlXoCGwMFCwkIBwICIgIGFQoJCAsCBBY
 CAwECHgcCF4AACgkQ86/NNaAhFjbm1gEA9t0Iaxr6IkGONOjD7eB10PjTYyDGVd4QdJYPohP8xRsA
 /0OETJIGSr5rxRqG23AGUdlnUfzFlgm3QuyfNpGHcv0C
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-plCQsqOv/roT4VMgIEBv"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-plCQsqOv/roT4VMgIEBv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-09-01 at 09:06 -0700, Guenter Roeck wrote:
> I'd want to see a message even if the watchdog is closed but left
> running
> on purpose. The best we can do is to add another message if there was
> an
> error when trying to stop the watchdog. That should not happen too
> often
> (well, not at all, really, unless there is a bug or hardware
> problem),
> so it would not really add noise.

Understood; I just submitted a second patch with your recommendations.
Thank you again!

--=-plCQsqOv/roT4VMgIEBv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSiWf/52F0/aGKJkZDzr801oCEWNgUCapdHPAAKCRDzr801oCEW
Nl8wAQDacccqHFMHxWnPqQGINQJicYgqTzMVbzdYZJnj/GmEjQEAgZ6WPay82xhx
SfLba8EhWQREVRDhT7prYNtGfGGp7AU=
=eWZy
-----END PGP SIGNATURE-----

--=-plCQsqOv/roT4VMgIEBv--

