Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC3F34F270
	for <linux-watchdog@vger.kernel.org>; Sun,  9 Aug 2026 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786295097; cv=none; b=rdXgyC6Xl7mciJGRlLdqpCbZ3+mDzMh4NwgzAYMr6FwGAqqk/V/4EhO1OQCEYfiTbnOPVoK841EVnvteEXQUvm5kNsid+BgBfH35J2lobWZGMZUwMNf4YA3CpliG0vSYWRl36t897wROkxRRBLTE5s05yT/LNUygbqPuZA9/VRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786295097; c=relaxed/simple;
	bh=ybOJ6GbjpjDv5vyM4Er83tDWnfgQIex0mLwBZ6eAP2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHobLxWoK+zBj6N3/my+IV7C+EgiTHMgh2wPYy/ds+AORxYjzvmU/anGdUgFqwvQiTm3nps4EAkFuW4eHCrV6ry5xCjAIxkX5e685eolTFSPQkpyAx2axyxAhzazs2NCAiKFr0l6DM38Jd3cHZGU0QVdRh5nya5exjNTxwQOhxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfFFV7pv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfFFV7pv"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso12505085ad.1
        for <linux-watchdog@vger.kernel.org>; Sun, 09 Aug 2026 10:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786295096; x=1786899896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P5JSOKGksaNKZfiKDtilTqpOi+B/vfPCWiy9wgHLU6A=;
        b=gfFFV7pvNyqFBxqHY0UbHV67LS4FQO042ct5zM3kfz4qshta5/1TWykTHhoALPN0nM
         9ijprUYXRLHpqXRa2Ookvc4tyl6wHNfv5uW/cB/0HQPSWPlMX35BXhAyNrs6OjRkuQb+
         zUa4XkGt97Rlo3fZGlmWEk44v2tdPUGUNS8FGdITk+cUmDV2MXZQy89+G8x/d4Wmop87
         leKEejKm4Hcx6EzdGqeExIAp7L8V0KtWCApJYumI5uwHcKd+u+lHKnjko+vPRnkt6Dzk
         8ZHmEQfc+K/o62JYKuQ5uWfW+bxcBgOJGd9YQ1VZiZ5sMejKu7GC3moEi2zGbKVV2ofN
         j+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786295096; x=1786899896;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P5JSOKGksaNKZfiKDtilTqpOi+B/vfPCWiy9wgHLU6A=;
        b=VOwU8m/CA+71Kh0F/IPeKbRsFw9HXmsne43CHWZ7v7jG69MV+oTnXQqOX4emh4KoWJ
         9GafTBhmvnnEsDGkoA/thxgLuc2blqs0b2hnV71J+MpxdOZPXcdpD5iLdtRvVJXUSEPL
         P8W/8ybA/+jeizrtp3ZhRtyudB7bYKx5ux2jnHhI2F42+NKq6VuQUINmOX/pcdDzUGfj
         QfoLwKa1mjQtenes34y+htRUi3HrEm04CdrPRapAmUmS4+00/jDBJUmb1uIJguCQbggw
         HfvPi3G2Csb1Uh8DDKvrcJl1sfFv/6w1cGVDmlH0lwXBaF0f5lO9SJtRU5EWBS0gadaj
         vGRA==
X-Forwarded-Encrypted: i=1; AHgh+Rqs0Uzn2X/IUar06dWU0VZ4URRMRyG2QVax9H0UzWtEwJ93xLChGUO9ROrc2YJ4bxE3yiD/5yfzxm8cSgE+KA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwmXBobsM3nnhOUl/MsLXVlMDcnCjLX+3RFzE1nfkcf0TaFSi9
	j4VYtd6SjGpLheE3stJCHry3WtTr11TevP0n5vefQCWuPB1UQimVAOOyMo+ofN8X
X-Gm-Gg: AR+sD13DUIT4YveYB6EAr3RDWYJsbj43cugwGSOb2AwCpB5WUTgMTvRUV8fXGXLtaHt
	6Lfj6PiZyscGUiI6lJzdVBdDKtC9IoCyhIrs5bncBfn7njJp06B4Fq1LR2QRDj8nlLigzO72d1t
	6izsvCz9ZJtbQnkBh67MM5ZMHIMKiAoczbqfJk8qo/A+Hf2r2mGDroUzmyQHlzsC3u+t9mfs1Oj
	r/8xU+MoJVQzd8idgum9m4WNYvfgcxYi0+nKGDJDo5qnmViIIFAYGTrgybSkBJ9fMYWYONamyQd
	MEX0xK+qaX3xC+FRWkAwAKoCEeKnNJieofMrdibujJCanNZTK9PkFfBm0DnnNxFDINU2js8Nzc1
	su7MwhXpU3G4TIot7wu89iDYFWOYByGTeETbeJV01GjJ5nR3HLEvvyg+QXsHC51Cq71ssA+BiiX
	O5dzffHV054cn3S3n6XXvlXoc8g5Wo/sQbp2EnVq4wofa8nSszlkJP3swqnXrdhO4ygme44sWRz
	q8Xj+R/ro+dqBHGnOPfRnuJuG3R/1tq
X-Received: by 2002:a05:6a20:4321:b0:3c3:b57b:6291 with SMTP id adf61e73a8af0-3cb85e6689fmr39981875637.18.1786295095808;
        Sun, 09 Aug 2026 10:04:55 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f1af985sm2824978a12.11.2026.08.09.10.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 10:04:54 -0700 (PDT)
Date: Mon, 10 Aug 2026 02:04:50 +0900
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/8] arm: dts: mediatek: mt6589: Enable toprgu reset
 controller
Message-ID: <aniv5B4jz07mI70D@buffalo-ssd>
References: <20260809160643.33991-1-l.scorcia@gmail.com>
 <20260809160643.33991-4-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809160643.33991-4-l.scorcia@gmail.com>

On Sun, Aug 09, 2026 at 06:03:27PM +0200, Luca Leonardo Scorcia wrote:
> Enable the toprgu reset controller feature for the mt6589 SoC. This
> allows generating reset signals for the 12 subsystems managed by its
> top reset generation unit.
> 
> Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>  arch/arm/boot/dts/mediatek/mt6589.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

I provided "Acked-by", not "Signed-off-by"...
https://lore.kernel.org/linux-mediatek/amEBgRmQktZ44jc1@buffalo-ssd/

PS: I am also fine with this patch carrying my Signed-off-by.
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>

Best Regards,
Akari
