Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2D4A341C
	for <linux-watchdog@vger.kernel.org>; Fri, 25 Sep 2026 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343698; cv=none; b=hH3cISdu7x9BB0xc7NlScxzTs4xLmbgBeWstw7xrIWuUj8Wkmlchn1SuwLdRKqwrRVNca52ij1/pUxjSdy3B9erw+lD2oIvHN+segZTglEp4fRO6oDKYc6Sr1fKphY2MI7/IF/AIZTCFGTt0TA8MXlYemoGg6DA6aTOP8MphXnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343698; c=relaxed/simple;
	bh=IRtWVZhPlxkGuhXNUXiZXi34XFGlsr0PVlco6/vlBjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNUcw4JWJJMr4memQRi4S1eRYakmwtM+yUv2kV6VsguGYErp0NZYyNDc2tq5lOIueOsqhUylIgyHi9UNl9+NolIZqRXjiU55md0LVggF7169xqhR7OSd29C8V+UPt98/NDPyeyIlB9Wl+DQojDyr1EnFJ7IAWEynDKxmC3oZA3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4DqYaXf; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4DqYaXf"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db1ca069c8so3892465ad.3
        for <linux-watchdog@vger.kernel.org>; Fri, 25 Sep 2026 06:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790343696; x=1790948496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8EotXx3jLW9THDoTXZj7S6IwWVn80ZyJZJ8OuSrsBPc=;
        b=e4DqYaXfTpfOpl1aWJs5Qaj58UxddJdY2lw0/CRVpzFdNJeCqdlo3ccPu96DryJpWK
         7o8DVD45wiPEaz00zmdX+yLQUtU1Afn9TUVmrcX+YZQP4OHfxx+bEarWcscpaCrvV/MO
         mS1XLIRi+JWgDNxMhiLYpw0ZPr0cGOa8LcXWKC7u91m6y7YOZVyMk1eTpQEMMnOwzfhl
         3686tdy4qPg5nW8iY4/++lGDkH43t910mxw/SOs0jUIQlSTdl+wN1x31zIMMreU4exZE
         kD6jO2o/Ncjqyuy7EjUHOTDSXbdXaoxf12VedXqyvoIfrA20an1sqiv0NiEBXp/qNsOg
         iVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790343696; x=1790948496;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8EotXx3jLW9THDoTXZj7S6IwWVn80ZyJZJ8OuSrsBPc=;
        b=zPImV9mG/Ouem3GzbEyHC0zzoKtXrRHoVOQ+wDMOK98tKmq00TUdgi+G62eQQzvLkm
         69wF/YmpyJX8wgVEJxXoiJyz+sGAx+V7SufhKXchLTgLAu9FEN0jbpFe0CB3qI9hqWpx
         iKAiJmbVK78BNvSHxaHzgOhwyjoUp9RYMBT3QkZ9RXvb0U7D9FdCoYnK59BH2sudmRLy
         3Rsk7rQw6YvOOGxBSzjlqHM/WUIq9CWnYQf10ORmskbyXNvrp8Nod7u/GNixQ+hIJWgq
         CKR4bmfImoSyAisayW6++DTFznP3kK6EUyoZuuhwFumRx6BJiSyWrFBENO9w4aFkG8oM
         CsBg==
X-Forwarded-Encrypted: i=1; AKwUvBw4kot3NP/6xsdZcQXmFiX6R2HYJTgjUy9xnElZO7apVtDxYUiu5X1Oga+wI1j4E6UV7UrT1x/gghh6l+dYyw==@vger.kernel.org
X-Gm-Message-State: AFuF++maCldXXv+E7UTmbV+fyioUcxMQF2pIq12BGfUqqsPzoGAjMxGL
	E8bQPFDekiOTa1NL7UU+76KuZKWnHaFTXkH5CGLmuNOvsLHyjFk3ze1Z
X-Gm-Gg: AYBFou3nsaOKaoNPQh8BobU1ovABIHfAltNqFzMEcZMTBuE4ACBuKAONPjRXbUedf5b
	bLwg05E6uHpxdMOQIPykOR4eq1wlv5P7AexKTXn2OQlSPmCQJrq0RYtqTTbvFWSxY7i+Hz8vd3M
	uHXfawwnRWrULTlEk/ZZuPO9u+h7dXDykLpuWWEciiIAyDE5pXKtvySkrknTLXY82g7nFuOpgRR
	Pg5JxJvu/dFzaCRj9D1RHsF5T5M2Ze2FyEGwb+2LUAqC2mg+il8Zpv948SqFTwH9yEz8k89wL4S
	piKKUIPQgoyx3r2ZsGrLTDKVsaNd5r3ASmCoe7GpuOfUxIYyrPrrZJvY7CRQVOptraaVTRhOThp
	gZi7xKKXJ70Af8dG+f2QfnG1sit48uexb9URx2Ej5uT5bJq9oXeSs+LtFZmXpTxKaPaBMOMBcBH
	WUIrRHT//++JLj3p0MVNIgQIdVSAZgB2dqrFJkS9Ju+cv+XiLD/DLiP7EzKxOjH/mrvvTMWtLps
	MSa1lq0hZzb
X-Received: by 2002:a17:902:f54a:b0:2dd:c100:b2cc with SMTP id d9443c01a7336-2df7dd61e8amr45900365ad.55.1790343696491;
        Fri, 25 Sep 2026 06:41:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91460aaasm10567165ad.73.2026.09.25.06.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 06:41:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 25 Sep 2026 06:41:34 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	wsa+renesas <wsa+renesas@sang-engineering.com>,
	"robh@kernel.org" <robh@kernel.org>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v6 6/8] watchdog: rzv2h: Add syscon support for WDTDCR
Message-ID: <17c04451-7e11-4d5f-a463-371466d41b0b@roeck-us.net>
References: <20260923105237.7B87D1F00893@smtp.kernel.org>
 <CA+V-a8uD16uG8cc9m7NHVZXT5bU64TYfu+_1POuXeioRAy6Z+A@mail.gmail.com>
 <4f5aadf0-8f23-4871-918f-430a0c99900d@roeck-us.net>
 <TY3PR01MB11346CC8B3C7374C293E0F3EB86802@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <2d32d7f1-f87b-45b3-9ccd-95e9773ca658@roeck-us.net>
 <TY3PR01MB113461EFFC2B9B39A53ED1D3386802@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CA+V-a8t3HKQ6D8jb_y-XM64BHkWm3vRw6JiTydSp3rqVr9nhdg@mail.gmail.com>
 <CAMuHMdXZwnRtp=f0iOiDqoLVjBTGVYNbbLeP9E3qjTn3RUEkUg@mail.gmail.com>
 <CA+V-a8tzLEScwpJ1Va-vpEHdJeOjo4v6K8_xTH=aAGZoxFHHbA@mail.gmail.com>
 <CA+V-a8uoYZ80rpmJ4RhOA45FwouJKtFtLznjrXDyiFp6Wne=Kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8uoYZ80rpmJ4RhOA45FwouJKtFtLznjrXDyiFp6Wne=Kw@mail.gmail.com>

On Fri, Sep 25, 2026 at 01:24:32PM +0100, Lad, Prabhakar wrote:
> The DT binding patch that adds the renesas,sysc property has now been
> merged [0].
> 
> While keeping syscon support, I propose adding
> rzt2h_cpg_wdtdcr_count_start(), which can be used safely in atomic
> contexts. For non-atomic cases, we can continue using syscon.
> 
> What do you think?

Whatever you folks think will work. Personally I think this is
over-engineering. If there is memory corruption or some serial
access failure (is that system really that fragile ?), you'll
have much more severe problems to deal with than reset not working.
I would not even try to "handle" that by mandating a second reset
handler, but it is your code, after all, so I'll accept it as long
as it works.

Guenter
