Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFF7349CC1
	for <linux-watchdog@vger.kernel.org>; Thu,  1 Oct 2026 03:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790826254; cv=pass; b=Q857IdBHbL41AqkO7lhDSyEDVBdVQWdNcdbGLns5EFQPEz4ytOLtvlZP3v/rHEQTGhU4byoduE41Gt9BQ56nb1mbB6VY31/45OO4uCrTyMyMp54X5FeyBxwLan4F4OpbS+bMTPi1rqgrNtpa0fyAZa/Xgj3XDCAnT/8X+Wdi7cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790826254; c=relaxed/simple;
	bh=LrQWUWcyoDeObLLAUc8VHSE0FIeAJ25asgQVsl+itso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdwmu3O2d2ZEJiwEL8mP6j75WrXFqdlvndj20eElbGPte24QYZjom6EQ4/NSWmsWPfw/hvuP5FZO1y2leq2ShGmeSmWytaEvWr/BNX1Inv+bfqQyMXvgsPyy/tpcb6Km8/UGZTw2gb6PMNQ7h5xSgTxMFPmMar1C8RPqHm6RPOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o9Jc1zxA; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9Jc1zxA"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-8198a3a54d7so2272034a34.1
        for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 20:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790826252; cv=none;
        d=google.com; s=arc-20260327;
        b=K8JmfWS3bOwbdQrBAO/UiCy/dyl1wKnSJ6/dVrn0BAPOt+Ls0LE6FxSdYKgKEca7/M
         30/vXx7V6vymLdwBkkFzytBecpHi/XfEzijtzWlrIs9xuDdiTGvNJBGca6STXpjY+dPN
         XZ4BwPHmcr/dk0Obn2n4vNTr8JejebVROeipiLKY4e4yTA+2dBTLs8Dx2xSeIIgaUFpB
         9N1sM3RcpisHD7DWakwdy7Mnm5rMubLJ5+5dEotRzSJs4PCl8FIkePe3iKAblB+4FvXS
         1H+vyDZcRoxlg6KKx9Ynx+dx2ck2N7mKumjzlBzpfEDVKCuNBOPgtYsrKERA5Mfd7C1v
         PtNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w4ijuTp5svOtTgrjejnJF22Eh5tEOHO/CkeB5GXCR3I=;
        fh=pfUtyhNH1Qp4TM+r6uLle38UkiFpzaQwQSlPIBx/0c8=;
        b=acVdZ0QtSx04XJje7LZYGr0Nq0agwaPgLUwXNfHjSL80he/z5NRIyZGjMLyOBdG5ET
         jqQp4T83L8Bq1etk9JmKNw8czNIr88eJ+ektCB1jiE6WxYNAQS89Y7heIvfOtpQ5iE/c
         kSibGDAtaO2cfOCni6wHkztwLG+g5SYkW7QItqm7kwDMOKWycW3ojc4SCO4/LWnnDMyc
         rIFoDxADHfTYMHBwqxaBnhoMEfxIguuUDbcZo6fy8PRD8jPR2Zu8Yhuq1SwJIZJ/wX4X
         LDTCT/fH3SEu9kXloCOT+JEIX2K+VvjzmuMIUjBXPaHITEdUGpypX4LgqQ1uHRbDxiBm
         mlVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790826252; x=1791431052; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w4ijuTp5svOtTgrjejnJF22Eh5tEOHO/CkeB5GXCR3I=;
        b=o9Jc1zxAb92HTvsoBZV+o+DGs/vsigXorO3UyF0yWl6ETaIFoCdaWFcnYsKbkQIsiT
         PqjlFb8c4gpi3qxABs1PJhN5O9fqNgVbB3FEeHladfxFP7uxut/9RI5eLgq80z/gDTXz
         YzO1N1j3t3RhEiWsgzsfC1+QfVMhzwA9TdWarQxiLRJh/jrWizyXnzS1xNsP4JzdPoOV
         Lz5yHWpPEKG6w/4Z+QGl6OMhEOkTsQO45UvDo4HNYWdlEWThIPQJU4x1TY7o/bJtnG8r
         +F9nVVlDJqNwhNDhXvMvye6drzN4OVYWFwneF5FsTjsDTHh6kfh3hGxIBjLdI28s3Xq6
         EiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790826252; x=1791431052;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w4ijuTp5svOtTgrjejnJF22Eh5tEOHO/CkeB5GXCR3I=;
        b=kBilQos01D8jdQKhN9JU85btj5Dai7TfBVw1UP27jsTf42fxTEZfu7pbk/j9MeWhzA
         G8exnpMWdBZL4T1tN2PutiyISX/y4W2Ed5cHEN9kHCukEcIMF2qeKzqHE2ex8C8Ls8JF
         kGh3wWWu/ioJ/I6Cel1Olkt69Z2OdXy5+cTEJqSQuPJMTi+xM9xakBLTebVzBI92eKHL
         M/WLNAbAct3404aZ8vp0+tqxo3HGA5VrARjj72lyb+g717dGN2/96OJ4KcY6URJgm4ka
         Le/PhUAfGRJNgbPhwIFVkIX+66FDSPQTH7hIMu8uyzxN9gRfCsZUwsY22lcWyARA+7BU
         8Ufg==
X-Forwarded-Encrypted: i=1; AKwUvBzkMpj4l51ES5PWwh7OFdjDQQ2a5j6SwV9Kq+57ExXZuaKpJ8P2XN0WaAcWg2AHqKUeDpNw3GCOfP2hqJNGyA==@vger.kernel.org
X-Gm-Message-State: AFuF++lmfuR/SMRD70zj7kBn4SvKxLveZA/8KEzzS4x3rYQfcA2m/ZUT
	W7Rslw7CTSrmIhQhuqg6+PJ7Xg+EXHF5llx4s9SuWbFJ8jzk3IQN0aXAhvExBkp5ZxwsnFTU1lE
	vFbqUZYbpFFY1vNVIHc85iDSPZUX5lCCp5cXc8c8=
X-Gm-Gg: AYBFou1pzUSHlAlYVBeCCSOUibXqlNT8xZkT8DoQ9gB7lEzXp2K05Mc4q44BdBgtpp8
	+a40AHvoL07+eRM4UoG5hF/w+FOSiuaUCyrrATCBpTYUS5kZoQuR1NDl4Ud4zbmKzFBHFEtmBpF
	Y4X1daiqqKue9RmbBjAJ4knM0p+UPmAgWEyxA8JlE6ozzlCdnhmg+fd6QonZDaU1BNJYMwkHSh3
	A21QoXj91cyOB+lap2o3j/5h8V02GEFjvQ5qlgFNZNyKQGAFPH3/Am3yvKOhu249bAFpxkKIozN
	/If+HY+sqAR0J2ZYue7Ng4TsA1JG9y3coOBSiNHWWCsnJGVOB6A2hWI1eHK7hrlwTh0=
X-Received: by 2002:a05:6820:4cc7:b0:6d9:58a1:824 with SMTP id
 006d021491bc7-6ddba7942ffmr1480642eaf.22.1790826251774; Wed, 30 Sep 2026
 20:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926-b4-mt7629-toprgu-v1-0-c124bf9ac273@gmail.com>
 <20260926-b4-mt7629-toprgu-v1-1-c124bf9ac273@gmail.com> <20260929-spiffy-harrier-of-snow-b78e7b@quoll>
In-Reply-To: <20260929-spiffy-harrier-of-snow-b78e7b@quoll>
From: Chuanhong Guo <gch981213@gmail.com>
Date: Thu, 1 Oct 2026 11:44:00 +0800
X-Gm-Features: AclHuK9LNVBWetA4umqzLuoUjfCXVTn1WDE30aATZ75mv1-R3SpbZ9mzZOo88bg
Message-ID: <CAJsYDVLimYZXk6mFrnsObCYFnK3HxqVJpuee+msnCi-GAUTXbQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: reset: mediatek: add MT7629 TOPRGU reset indices
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

On Tue, Sep 29, 2026 at 4:44=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Sat, Sep 26, 2026 at 07:13:59PM +0800, Chuanhong Guo wrote:
> > Define all seven reset IDs documented in the MT7629 TOPRGU SWSYSRST
> > register: INFRA, ETHDMA, DDRPHY, INFRA_AO, CONN, APMIXED and CONN_MCU.
> > Use their register bit positions as reset IDs.
>
> If so, I say you don't need bindings then... but fine except:
>
> >
> > Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> > ---
> >  include/dt-bindings/reset/mt7629-resets.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/include/dt-bindings/reset/mt7629-resets.h b/include/dt-bin=
dings/reset/mt7629-resets.h
> > index 6bb85734f68d..828919eee298 100644
> > --- a/include/dt-bindings/reset/mt7629-resets.h
> > +++ b/include/dt-bindings/reset/mt7629-resets.h
> > @@ -53,6 +53,15 @@
> >  #define MT7629_PCIE0_USER_RST                        30
> >  #define MT7629_PCIE0_PIPE_RST                        31
> >
> > +/* TOPRGU resets */
>
> Didn't new bindings switch to continues indexes?
>

This is written for the existing reset driver in mtk_wdt.c. I don't
want to add a reset id remap when all the other SoCs in that
driver use binding ids matching their hardware bits.

Is this OK for existing drivers?
I can also live with plain numbers in the device tree if that's preferred.

Another option would be to include mt7622-resets.h for mt7629 dt
as their TOPRGU definitions match exactly. But that would bring other
unused mt7622 definitions into mt7629 dt, probably not ideal.

> > +#define MT7629_TOPRGU_INFRA_SW_RST           0
> > +#define MT7629_TOPRGU_ETHDMA_SW_RST          1
> > +#define MT7629_TOPRGU_DDRPHY_SW_RST          6
> > +#define MT7629_TOPRGU_INFRA_AO_SW_RST                8
>
> Best regards,
> Krzysztof
>

--
Regards,
Chuanhong Guo
