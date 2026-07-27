Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747D5175A60
	for <linux-watchdog@vger.kernel.org>; Mon, 27 Jul 2026 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785149813; cv=pass; b=WSZAtfgU3TAta56yBJmOYwIK8Fj7KOitARfSbObNP535UOpSqfp0bUNWH3kGpN3Bo4jJE9mqOCvMduIcVNrHS53PDV4s1K3iQ9ugXuJlE/8P0yBed4l51ch723+oQDU+tzXQkPiF0Ke5U5lWZVPkeFamwtNADDJ2RD3/jMt0sPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785149813; c=relaxed/simple;
	bh=Zb69OLu5ACzcZkGGJOST+3PwfbqmpSOyBQbGD2dPAjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NU+bQSmOXTMU0R3iYQntYMVZaC8NRbsdi+f+Rk4a1Knyk3ZkttpDuSpyGUDI0E2L72OMkxThEbAVpG73hkTH/OIYp9e06WAUe3oYToKoh+pcecjCFd8/pc0HXUpcHczeTQdP20eq2Liaecs2Rd0+47DiPtUuAcRx7hxobpBDw/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oWw9tMzh; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWw9tMzh"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso1322799f8f.3
        for <linux-watchdog@vger.kernel.org>; Mon, 27 Jul 2026 03:56:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785149810; cv=none;
        d=google.com; s=arc-20260327;
        b=iTmyExomk8IHpYDQH7wEovxXCy+01mIkt+vbQr5Z67vQd4XMnsSAw9P0c/jv4rEBdB
         spub9kbFaPod11I8ZwEGDre8Bfo76PAs3biw3C8Klll3oHBN9Camp2yFTuMNT6tG58Pe
         fmzzHzqgfrS+EQn5ezdEK+fC52qUp4tKaxwjnyItQDimM9kZ8PgJJ6ZW8o/4SAg1MduW
         JhCuMgcNrZv8P5hmPNNIeUh1DOKTepmjqizatAZ6dkgJjWUijGLk3pDwO9cLnbsTBSoR
         obWdDZBmJye4LBCDwZBPxI1ds8lTGzILn2hwYhAb9BUlR7jZ0jZxBj+SsBvbpylB4Vv2
         ckvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zb69OLu5ACzcZkGGJOST+3PwfbqmpSOyBQbGD2dPAjA=;
        fh=D0WVjchuYhybhEZgxCV4Cx+g6J8Vs2SEBoK19qqr3mg=;
        b=RxN/k0dmuOoaTASESCp/g3xyhuzrVairf+bPZa4Wga7JtSqz+P/eXKPBO8sckRA5pn
         lsUowlJlLO/DXQ1Xd7TqhzkabiqlrBwhVo6r2+aplOXMMQdfWvfykj65Y6OWQ70r2JT2
         c+w5kWryellRwf8Edirmlc6JSfl7mxF2TDMzMrTvb8/fT8hjDqK/wJTOePumiwa+suH4
         Sg8aFUExXjm9z+NmGu0w1LNlGN4tiMepEhv0tT4t/sKo8SJevfBNF7R8ar3tSdEGOKnQ
         SNa/dklo2kKZ09cLpNF9x2J6c+qWHBD/JwtiU04qYQ4FJ/CV6XoYs5LxUSs/uCHGzT49
         /Oyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785149810; x=1785754610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zb69OLu5ACzcZkGGJOST+3PwfbqmpSOyBQbGD2dPAjA=;
        b=oWw9tMzhuUXZ2OBl/YU5rCTjG2DDcpNv9Bz9lvP1q86HDINYRiMROFjSQCp9AwdmA/
         ajkYOMtEZHTCTsVZQdcSmY2vR6pZ/clkvQtum9wSPgN0PMDALSn8IBIbSVxLLkh65VnO
         J+fGYJ+WhwTBXg1N55mR2ngBnFjCdonTN93DtCon8niGBcJo8SAADCaVbzt2KwTA2gKT
         Jx3kvWyu91y0936+XbEohO1366rWNKgoRZirTQjicwrnYPcCuf+UeXdT53w9mY6SVlze
         YYIVLd1AnZ2Q7xgy3TjKLcT0KO+7CnHyG4/qAtJ8QMcqZFjOt4jTzLbedwMl7Gw/XhvV
         O03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785149810; x=1785754610;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zb69OLu5ACzcZkGGJOST+3PwfbqmpSOyBQbGD2dPAjA=;
        b=FumjFQ+4+WLYTMsxjGzGoXTRicEToT60RrqvbTfUsvtX0qVQyNWBUQcwsRQGLeUr9F
         zGMH6Lz+hSlyes6sN6vOrp4buJRsKvBZuFSMsUsg+ZhGzh5NDML/9lpa2ffo3Jixw8RC
         PJ7MnSwYn96cVqwCy3ixJjdiaprsMq+OM3r7mmK5YtZ7VGZYU4kIijVqgkhuhf9tllfc
         MqgtF5iXP49oiewJQo3ji1AajGk8y7W44qe5PdECpLlj8Tepv8IkAtRF///zmzscEsT/
         8uEc4lpQwQZRMhiXmN6x43wOf7Vlp8cerpXysYbV1lSEJQxrwYgRXXE+d3qvG3k7W87y
         fyZg==
X-Forwarded-Encrypted: i=1; AHgh+Rpm+ZqOeH54BmQQ+2zhLRENAAhpVMuqvJWsTgAfDdVQAFxIXdx5mwCmMTKJjaJeiXj6ds7ZTeNxQfu4563vjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy7shgfYTNnAF+lM9QOP6sVUnok106MIlr8mkh48jTqoF5c3sZ
	nqA3u2zyd1SPXcQEMfyAY++mCiwoeInn60pN4CBkUnFs4x55FIo0xQOIYzvF+5Wf7xGML4Pv1u2
	k25ak1Vhru1Pr3sky3hN9wVH165e48yw=
X-Gm-Gg: AR+sD11TdoQQt9LIGGMq6Ag2xB/rcWUmSR4aSUu0Bt7OOVvff0NzxKB3K/nZw+6o8Yh
	zcNrx5qC3WtsIH34YW8zSdnGfFjlVpjdUzjZJE3cEAXl/S1VsvKhuTngBbSivNHOrqn2upREhZj
	bLc282qLeRzB+GqOEFJN+dugT8Gevgq/dCCeQDu2PsfCmt6I+C4LIRaoCFrHBel1XflxM9hg39s
	Yd3K2zBvcC87auk6JYPOxSOEhlRqhMiZxq/Yc511aOlQlk2qrnR2cOaEiacFZP8crJV49Hyt4ns
	mRILo+WBpSDirOCBHoZ0Hv+DgIZLsDhEz2P3GMTvCDNAyEgcihAkkAAZ4/9pAbilklEFH46ACW0
	uUYaS
X-Received: by 2002:a05:6000:26c4:b0:47d:efd0:c026 with SMTP id
 ffacd0b85a97d-47fae777871mr155440f8f.11.1785149810531; Mon, 27 Jul 2026
 03:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715133922.2129340-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260715133922.2129340-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <cf85d5b6-7d9d-46a6-9ec5-ab0a17c9515f@roeck-us.net>
In-Reply-To: <cf85d5b6-7d9d-46a6-9ec5-ab0a17c9515f@roeck-us.net>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 27 Jul 2026 11:56:24 +0100
X-Gm-Features: AUfX_mxmlLrUi-qyrqGmG9f_iX2kOW518hAqzrSNzWAm7CtPRIwdS-Nai2Cmmbg
Message-ID: <CA+V-a8tQLLGi8QeWhqsh4H9ixMwSB_Hcq-eBgmwoz9_n8F44jQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] watchdog: rzv2h: Drop WDTRCR_RSTIRQS macro
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-watchdog@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

Thank you for the review.

On Mon, Jul 20, 2026 at 3:58=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Wed, Jul 15, 2026 at 02:39:22PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > WDTRCR_RSTIRQS macro is unused so drop it.
>
> Nit: This is a define, not a macro.
>
Ok, I will reword the description.

Cheers,
Prabhakar
