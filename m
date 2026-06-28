Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A2022D7A9
	for <linux-watchdog@vger.kernel.org>; Sun, 28 Jun 2026 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782630123; cv=pass; b=A7ngvBiLx4wXE4eOh9KcOorNB0f22s2xxyvQbD8N60kErsbrvaKB+383uRWEfJdWUxklcJA3Virp4xLXkwUc1wGgiOqVCI6S9MUeOjR8Cvgsa7+Xewbp490pSfN8qRkiMzfMDl2Rr7T0Q0YkHatHUPH3irUZERUCFJ1Rvnbajco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782630123; c=relaxed/simple;
	bh=GY4pj5xmpcn7UP2PeAYAwybK3ew5+HG7uoyXdtWG2wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gpNpPEghemf5EZbhuLkegbBZ7oriDu3KovMZsrBlrv/mkJlLXViwZyhv0T42Bq2Ion7FQ2PlwECliFoVcVk3x0VTuJM3CYYeuovjepli6Au8z5RhxgIKXjJkEewnhAq4LRnDbPwaYcsJVlxaHAhWA2AezQYZYxxMuWgOKh1CQQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQkNl8rg; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQkNl8rg"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-664c4a04081so163111d50.2
        for <linux-watchdog@vger.kernel.org>; Sun, 28 Jun 2026 00:02:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782630120; cv=none;
        d=google.com; s=arc-20260327;
        b=h6hf1k5ZWuyI47Wmhu6lZFPmjiVP+u2lem2HIfOgnRk7+Ve3NEslEXuIVU4CFZhbZ1
         /rB4KnpPjLKQlMagh9WFFoENdDy4KD30HvckwihDNhqc3VDFa/Y8135y1LlQV8KRoo1r
         Y5GLlMKp/m/tvX4Hq5Aav9tvpcpIKsFq4gGAyIDgm44+nz+M8PzLphmjJdwkpViQ2eZG
         la9myA6YkWRs9bmYKlr8pH5hhfz+CVNwHzCXNrRzpcgzpbyGC5uo/3IYEHiat97pdP2r
         65FLoog21f+Riyk2C/YVAkSgvGMvI2oUDMWt2XXRpaQsZE3KXDKLZs27iMZKgrvOtH5a
         ppKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+OId4Ok77F5YJbguyUedoxMERWa5HS2eOIQ/JijyeTg=;
        fh=SxEI49jmfKlHX7l0RwqN/L8yfa2+YDfn041u/QTi/FA=;
        b=NrnhBhyz91GcZbT5u6cmgvv7/iqlQCkROBHq4I996PTLRFwT+XZtAIXBBFXtTVqMS+
         Lyl9XiOm7q5lVNhBifh1f4O51bgGTIl8fPrC3i0/LnwBNMgWey5opfGBm6eS0xygtWud
         FCa/TEIVdspv99Tdhnz5Lyp4g27vISLduIt0r8tt2eVpXUSYARmfmfMl2WY/Iomnm1dS
         s3mua+A+pyMdU5zNzHjm7+Qk1TGz0ekQ9tWd+yhyaImf7wvWeys5QMWFvjAHGk8L0inn
         nROsAFUN99wgiOdS9fVF1DkN1FIqcF5N6fpaGi2GJkZaQGE4JhznAEKqmo6VG6GmTow4
         DNZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782630120; x=1783234920; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+OId4Ok77F5YJbguyUedoxMERWa5HS2eOIQ/JijyeTg=;
        b=AQkNl8rgTfKxMVSAtCN89DB2I0uds+ZfyykkNh1FuW4Ha5PIzi23m2zOXzdbZhISH5
         FcpHniGTt2t3q/3TrJ4X2gm7PAb27vsh1fSoJS6YkXMslsLjixrG4uZxCOFPtA0tUprO
         Ju0XmD8lPhg1zFVyCSP4ocqLTnEeUKwNxg/62T2vL4rT4E+/6cMTRc8BVaP18729+c/0
         mmU11K1CEfk3MyD8w/n+J7rh31HGnPbHPAnGLcM0UYmcFFl9N5I+hVPCu65ALWh7bPUr
         2MTbU4dGBzEAZexxx/dgk1vDRDCJUdrEcEgHcfvm/zQ6daWHpPzgpuVXjNWwFkSHZ0d5
         prYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782630120; x=1783234920;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OId4Ok77F5YJbguyUedoxMERWa5HS2eOIQ/JijyeTg=;
        b=hJ5bn+j72ZKl8hR0bhQaQCrB2keW1t0Uup5XegE9hn81HkB1T2p/gokiTtI5YHzlso
         SkiTW3zvgRNpxXhHXdMPgXULCtHpDJHboAmaHDnDmUY+LRIx3sP0XeTFZ81FBxBFvP7m
         ZVKzG3fsCnNPum5i1Ey2J0EspK8QQb2ZjmTvMjy5zQd8erbLJLe3HAWgqNIPjip1zaaW
         y0AQRcJy529jnYplVK4GWEXvkJ9x2ILqlRVe7JWSlxN16uzY2gNuPrrzBJvqX+V33IuE
         ZTvUbTvCWyhsMvKHC+17y899SSP8/jul/MawtU+HdBrtDY/wo5E1H/jKncYJ7dOKUnj3
         lbHA==
X-Forwarded-Encrypted: i=1; AHgh+RpzjMQ6A4byA6tImLATQIwc6QSFe5bePS2RrWqkU3YdlQmHMClvJPksLVXDpGE9uS+xjMBDHLK564dLFDIYWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxNiEoQ9ISPZMrUei4YHWDqSxfbQehNkKd25Merr3Ga3b+LbVm
	9UyyxtJHb9+Stdby6C86NxdFzbB1OImxSwz1TPQc9x+m52Tqha2gaPTHh9QdlDxDqLAaTjqE+48
	WfhYtRuNjqh5McVid4VQhJ7dCoQnuIkOBKQ==
X-Gm-Gg: AfdE7cmwXthYpK1xMeIJ8HuWKiviv60tfoKB5iDj1RS25nkLv1pAds+G8wN3NxE6EfG
	4SiG+dhsqa4kMxC0qfWTOk9OPIszUXtNI/PFkqVMgtwhjwMgkIra6GTIVWp1Gc3RuOHx0CG+sAn
	6vY3JoudQLLPWNn2jC8Ghi6LsOHBojkohI1JEAxGOkeAdFaQzYKdUffjOFsa9ls+oh0cbitlN03
	kJ4zT0RtuUypxtSe0yts3gaYhdf0nc4MVkYYY4klzeJNlpWF3ih8W2/7xTpdY1CdgrVlaXvdA==
X-Received: by 2002:a05:690e:4384:b0:65c:4b71:e6b4 with SMTP id
 956f58d0204a3-66488152a26mr8488609d50.20.1782630119792; Sun, 28 Jun 2026
 00:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622083046.3189603-1-tmaimon77@gmail.com> <20260622083046.3189603-2-tmaimon77@gmail.com>
 <20260623-ochre-spoonbill-of-security-a4bc42@quoll>
In-Reply-To: <20260623-ochre-spoonbill-of-security-a4bc42@quoll>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Sun, 28 Jun 2026 10:01:49 +0300
X-Gm-Features: AVVi8CfRBhsj1pRWdOM2CE0sqTqASlUrWhsQBJl0HJjSQATVDmJtM7eZQvBwA6g
Message-ID: <CAP6Zq1g-dBdt=cgqfxn=8qVX=UBs5-w09YqDvHfi1y=h4H9DKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: watchdog: npcm: add GCR syscon property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: andrew@codeconstruct.com.au, wim@linux-watchdog.org, linux@roeck-us.net, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	openbmc@lists.ozlabs.org, linux-watchdog@vger.kernel.org, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, avifishman70@gmail.com, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, joel@jms.id.au
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Tue, 23 Jun 2026 at 11:05, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Mon, Jun 22, 2026 at 11:30:44AM +0300, Tomer Maimon wrote:
> > Describe syscon property that handles general control registers (GCR) in
> > Nuvoton BMC NPCM watchdog driver.
>
> Why? Well, you try to answer by saying something about driver, but we do
> not add bindings for drivers. Instead hardware should be the reason.
>
> Anyway, why is this needed now?
It is needed for accessing the reset indication registers. I would
mention it in the commit message.
>
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  .../devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml   | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml b/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml
> > index 7aa30f5b5c49..4f00f099b2d2 100644
> > --- a/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml
> > +++ b/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml
> > @@ -40,6 +40,12 @@ properties:
> >    clock-frequency:
> >      description: Frequency in Hz of the clock that drives the NPCM timer.
> >
> > +  nuvoton,sysgcr:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      a phandle to access GCR registers on NPCM750 and NPCM845 watchdog
> > +      instances.
>
> Here you write also for what purpose.
>
>
> Best regards,
> Krzysztof
>

Thanks,

Tomer
