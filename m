Received: from mail-wr2-f21.google.com (mail-wr2-f21.google.com [74.125.225.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9E8481A94
	for <linux-watchdog@vger.kernel.org>; Fri, 25 Sep 2026 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328090; cv=pass; b=gDEohEhsoAsjhhYgkidsXyLmOFHb7NVxeUI5CjFl3ankdFtspAEoeqHdmfJ4AGKfV2HWlDcdsm7+XcljGO3hb2XkcCW+Fz0c/Z19mrkSP4nD7jJoB9Rzp6SwDR/r7KbQikMXxRgDl/AluEh81U/z2U+lcLzpqzDfoXS7/GgVnUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328090; c=relaxed/simple;
	bh=NCueJ4dcU3NpqgGF7u84YtQGIxF+FQ97Y+VznPDBXYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=STLEoptCwpvz28PQR4jhDdVKlmRBHSf8sLtAovtnWnZLC72oEQFXwuLGidQvJsSbijbzdec2GsfTuefxybGuVjLdLvvhnGQQnIr1fTr+rVUXR24ehOfAzgnqYwsOHNClf7BcoZD2K9scch/fuI70pej8IJswQFIPnPOEI0LIEdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFnL5Uni; arc=pass smtp.client-ip=74.125.225.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFnL5Uni"
Received: by mail-wr2-f21.google.com with SMTP id ffacd0b85a97d-48881a62e09so121776f8f.2
        for <linux-watchdog@vger.kernel.org>; Fri, 25 Sep 2026 02:21:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790328083; cv=none;
        d=google.com; s=arc-20260327;
        b=U/QZ3xxtn7OEKxKNiTaqrgKu4LKf6Mr1AcEtn6zg18Igz6qqr8DSxgsKxCPVeQrAxo
         9Ux8SPmD82OcXiRuFz+isDb2uVCS8swLRJXylRodv6b3la/TF6Xdcc/XXvSnCriaaSkt
         8G7r8Y9oVYJcgFATlhUqzTNxebqSwR32imh3sf7QY3NjtR/Mex8sX5eOB85iqGKH4fN1
         tqPZAcHn/6U3BUxLBSHz8HwbHuxSkC9+7x/c3Fai2J6PTDydOL5vrq3R06cr3skmmMDE
         InURD/3ghXHqV0Uq5PcZJ72cSK+l0XXeSTkSt+Zx+YNsaR108SPwn78pzVQE7TE5I0P3
         nsBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZlooN9kx6gRrXmg2e0W2xusZ6bAGGvgElZ4hCzz0Zhs=;
        fh=ZzF7DjKs1WUwjUhxqbL4j+cgTnCo50wfoDgzcEUQARU=;
        b=UP6MJMGfv0oQgaF5AO2GySofEaLTH5ZCUvwVm/1bGNGaWJ2D0sBckxmxkE+jL7tYyZ
         m4fohlbjxfawnZ3dHyphcQqP6yxocaZrd1W6P8JreHcs/C3fJpCZ/FuvMq/czdYWGqyt
         vrs/RPLh8/pdizVqMJbvUuv/ZXHi32SgL0mLRyaezhLFopONn1Q7v22NMIQblQsUpvpK
         IxL82Fn2dzmXaqxBUzwHV9Lm5Stgw7t0kdMWAbPTLTmvzRnh0n9EjGCMxCmmPLBGB9r/
         ZeD1+PADpGocRmuOSeTIANSWdpx3GlWHgKMHs2m9AyNRe9wb3QJes0jbtnChGW4ihiD4
         YUkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790328083; x=1790932883; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZlooN9kx6gRrXmg2e0W2xusZ6bAGGvgElZ4hCzz0Zhs=;
        b=BFnL5UniNGwXofIkCcNfbm68Zfk73lgHVuQq3Q1AZcFbNpcVVz5p0spJ2rmKrc9dt4
         Cj3OO7PsFnuKItjfAzUjRANDGpn/OJZa8BhBX3e2l2Nbnucz9Su7KsrGOFk19654nCbA
         DlvIKmpG20HysfCq0FUnbD+6HTwsQjWwjjKaUgX+NTGCFTQmEjYTMG+IJZLtaZbL1+Jz
         T6D2sPTxFFXvKauUOjZhyK48/ouoGTNntwzl1WbulGHyoTyWdfQoTMlSdMoQcElVSWmz
         8jZwqifkZiwEGu1Vpm5PvcC0tymaZNOjxMWENS+Ggu4UdSbkaX6tJUQ0Q0ty5JufvMsr
         qTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790328083; x=1790932883;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZlooN9kx6gRrXmg2e0W2xusZ6bAGGvgElZ4hCzz0Zhs=;
        b=eTooEOAWt80l9vsHtSQ6DT9x/lWnvLdSdWNpazw5IGQOiKwZvFbukEnSr2DWglTTgS
         4k30TafXC5y290cINfba+xGrz8ZUQGG+iqWtJQb22dj4MHqQL+gxyVQdoNaWLBy1yBL1
         d4dQa9thh6hjVC7LY2ugZb5azIC6CeNvWOEgSfzetpEBsfSV7MVTwc5RMG8LvISzv05f
         PzUTAMBPGVwJoFRjzblPNWToQAbfnnDbt4A6BHw+Q+TUyatdOteJvIkk5pUZuMBbeKbn
         eQT3zk/CT0LP633TfDTRiWNYrC8Mji/r0WmEgt6vhXsuKJx2/2jKh9v+YZLEhc1Di1mq
         e9hg==
X-Forwarded-Encrypted: i=1; AKwUvBz7yUaGwOj3xkWWpkBzHtNAlRdR31DRNsfeX3nc26I9dSGGVAiH8d1FoL1GY76Z3oiqKTXDXhJmW8JYZ3CjiQ==@vger.kernel.org
X-Gm-Message-State: AFuF++luVkuC0ga3lD66yqHWNdOABkXcUxIwxcZrNHGmYVxopPGAjhUz
	0awMPkXORPq+F479nME//OtonLcYgOZvCDq7JLDnDnZtFslsswtwq+wSn7AA7U3dRt3EMNEbjjm
	OBwTNK/madH5+cOy7YZQOupmF3LMmCuJZoUbCb2I=
X-Gm-Gg: AYBFou0RcZ5yFA/d80e6NyWjQGcsIcUxdOBaT+iJ/YpUPV7Pbs27IdZ8+rjvf8xaXf+
	SabRdNBb6sifD7IDon0h9VMNIJcziDcsHUGJgWmJC6qq0pbfqKunDGKMEzTrNHQ+9NPa/sP9QXC
	PbpR54t02LSSZHIM5qIMFfwI9NdwykuXdMIMuKWoTkUnGnsEEzArc457hKJyand60Cnz7W/Z92I
	nwP4ZqeOfiWITBUcj2zk5bXggznAzOkOhSz/S3Fqu5aX0qqXrdfVuWUUlO3JRcc6LYwe+9lnHr8
	u1x9vVCaurMCn5qXXRNIEpoayTjYu/vLaoTNbkCUyfhZDjqfUkelD8h3Ktk9MR5j+oWqgWOySED
	sSroIOwQZx84aulk96zGMGwVaMB1RuZgfPU8Z19YhWq2fH0csB/OfIdEYxHmvZG5k4tvA8GxQ
X-Received: by 2002:a05:6000:460f:b0:487:a46:a9cf with SMTP id
 ffacd0b85a97d-4887174c0famr8766945f8f.29.1790328083300; Fri, 25 Sep 2026
 02:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923104054.3324830-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260923104054.3324830-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260923105237.7B87D1F00893@smtp.kernel.org> <CA+V-a8uD16uG8cc9m7NHVZXT5bU64TYfu+_1POuXeioRAy6Z+A@mail.gmail.com>
 <4f5aadf0-8f23-4871-918f-430a0c99900d@roeck-us.net> <TY3PR01MB11346CC8B3C7374C293E0F3EB86802@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <2d32d7f1-f87b-45b3-9ccd-95e9773ca658@roeck-us.net> <TY3PR01MB113461EFFC2B9B39A53ED1D3386802@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CA+V-a8t3HKQ6D8jb_y-XM64BHkWm3vRw6JiTydSp3rqVr9nhdg@mail.gmail.com> <CAMuHMdXZwnRtp=f0iOiDqoLVjBTGVYNbbLeP9E3qjTn3RUEkUg@mail.gmail.com>
In-Reply-To: <CAMuHMdXZwnRtp=f0iOiDqoLVjBTGVYNbbLeP9E3qjTn3RUEkUg@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 25 Sep 2026 10:20:56 +0100
X-Gm-Features: AclHuK--x_qeFFnhJWfBmO_fp3zwDw0cPGYw1M7_Cyl9HfxYZY4jYF_Kzh6z3Zs
Message-ID: <CA+V-a8tzLEScwpJ1Va-vpEHdJeOjo4v6K8_xTH=aAGZoxFHHbA@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] watchdog: rzv2h: Add syscon support for WDTDCR
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Guenter Roeck <linux@roeck-us.net>, 
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, 
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"wsa+renesas" <wsa+renesas@sang-engineering.com>, "robh@kernel.org" <robh@kernel.org>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Fri, Sep 25, 2026 at 10:09=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Fri, 25 Sept 2026 at 11:06, Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Fri, Sep 25, 2026 at 6:11=E2=80=AFAM Biju Das <biju.das.jz@bp.renesa=
s.com> wrote:
> > > > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> > > > On Fri, Sep 25, 2026 at 04:13:24AM +0000, Biju Das wrote:
> > > > > Just a question,
> > > > > For automatic software upgrade, if the reboot using PSCI fails, w=
hat
> > > > > is the fallback for reboot, reset the board?
> > > >
> > > > That seems to be a bit theoretic. The reason for having the ability=
 to register multiple restart handlers
> > > > is not to have failure fallbacks, but to have fallbacks if preferre=
d restart handlers are not available.
> > > > If the PSCI restart handler is present, it is expected to work.
> > > > That is why it has higher priority. The idea is to use the highest =
priority restart handler, not to try
> > > > one after another.
> > > >
> > > > Sure, the failure fallback works as well, but that doesn't mean tha=
t fallbacks should be provided just to
> > > > provide fallbacks.
> > > >
> > > > If you claim that the PSCI restart handler does not work on this sy=
stem, provide evicence, and we can
> > > > discuss this further.
> > >
> > > I agree normal cases there won't be any failures
> > >
> > > I never heard about PSCI restart fails. But have seen a case due to a=
 bug in
>
> Oh yes, if PSCI is not really implemented ;-)
>
> > > serial driver that made the PSCI restart to fail as it hangs the syst=
ems.
> > >
> > > So, if this is the case, a memory corruption can cause the same.
> > >
> > > Long back I worked on femto based product(single core), where we have=
 normal restart
> > > and a fallback watchdog restart. But it does not have PSCI system han=
dlers.
> > > On some cases, we have seen automatic upgrade failed because of failu=
re in
> > > normal restart.
> > >
> > If you think the PSCI might fail and not restart the machine the other
> > alternative would be to export functions to configure WDTDCR using
> > readl/writel.
>
> Well, if PSCI resets fails: that's exactly why you have a watchdog
> (or two) in the system, right?
>
Agreed, To avoid taking the syscon lock from restart context, how
about exporting helpers from the CPG/MSSR driver to start/stop the
WDTDCR count using plain readl/writel? Each WDTDCR register belongs to
a single watchdog instance, so no locking is needed.

  /* include/linux/soc/renesas/renesas.h */
  int rzt2h_cpg_wdtdcr_count_start(unsigned int wdt_index);
  int rzt2h_cpg_wdtdcr_count_stop(unsigned int wdt_index);

Cheers,
Prabhakar
