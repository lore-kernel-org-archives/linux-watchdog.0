Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5680C4AC14D
	for <linux-watchdog@vger.kernel.org>; Fri, 25 Sep 2026 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346245; cv=none; b=tV8pObF9TnjtK5TVsIsxXCziCOwpR634CMsVKWw1g4AntekCGuBY6DL5A1NEkp+56iwcvUNX0nER1BJhPmTVdtIW4dhZFlq7w9LFiBBH0pNJyNNywvyOGXrJUhvzGUi9t8tm9+/iO4yZD7xl0BhkDqLD6LMsz3eoQQNnIMON5bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346245; c=relaxed/simple;
	bh=hnby5Ne/xYBp9U/09T9kv3WEIbUsqL+xI/HH6LFetjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mslBwt4FcihLvpWrxYRPJ0VMhngShiSyEP8twSu6zpxc6e06g10hxgRFx+hDMzIEa4MA/AWPM79++9uibghmyNb2YH6jth1/vgk9piFd5jyotipdPj1JcIql+0kfE33FcHESCdk/AKUWrelJ7dq2tYKNFfsuB9mfixbmkABLnjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqXuNG2M; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqXuNG2M"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd88a115ebso5088895ad.2
        for <linux-watchdog@vger.kernel.org>; Fri, 25 Sep 2026 07:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790346241; x=1790951041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E0I0TIKEyiasgHy1ngA6HhdOkD8Gr+np1P2q8hO6FMM=;
        b=XqXuNG2McZuqUvqTs6YTyK+9nrDTQqNJTrvZaHU8p8/pp6Pcz0zkB4mNZBAWXo5lno
         UYzedwLYjyiZ2I2wNq0hcZfkkUAdxE9CIhp2/J2bWqZBW8Q46QeimNr4FaQVzzJeycKA
         4imV5nJci+/8sNrA9vP64DfrZmPszV/k/yNAmmZFkNEjGG7qKJg11zzMvkNZS3NDiK27
         k9Zs1dyF2tL0KA/7uAXRpOTBChtb4pXNNPdp5cFzWgywJESfHv3ETeqho0jCiNnXMsfT
         9xjUaq33ZLoiOcL54RElXkj2ME5Cj+MqtL34xgXmiYK9JO9U9ZUa3DNQBL9X9bJAdjus
         61Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790346241; x=1790951041;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E0I0TIKEyiasgHy1ngA6HhdOkD8Gr+np1P2q8hO6FMM=;
        b=NcsIfbaWb3ESVbyULsy/sboyN7hRUF6mVImtjNebIK48tIdnBW37fLvtuoRr45Thrj
         dUJiVE5AlzCb2RZ6pTJ59zl+CDbeHG2OUSo/PqyT9I4uf13yr84MsPLpXLB4SM3+iv3m
         grzx6cRTnqpVzx0R6YogrOn/AtkKLeqMl6pwqF9+OcRc1Wad018sbikQsOfFTtVDTB4J
         4ova389svcoCtBwW5wCkxjr7hjLtnC8o0jvNzpFhancQ4hgl+oOA21X29fCGX5iwBW37
         VLqWsyHA2x2sW7SZMvY5NuPZTvGH6EHG5kqR+uQl5hHwiJFaHmEaouGflGHqkHhOfGX0
         IaAg==
X-Forwarded-Encrypted: i=1; AKwUvBwTAfexGAqBCcXcIUjeJ6J7nl9r7Cp+Vfx75InLxeGP4CSeX0tcG8xCCUSjRWvbSLesuKbGsHtHlqCrIFa1RQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mz+yqyP+FeeqY5259x8+oHZCcqJCjB4B5mvoFwcYXjFQX8r2Ek
	u9LvXTn/MdzbNfevaAMr3dlXbGN2DtSOr2mNYssGrc+vzHlO4C6HXTqg
X-Gm-Gg: AYBFou28bvNroBYqi787hHPJK+fiVaue48DxEn7hpOmpyXVZKqDQvUCPgw79ubocpjk
	3GwKlZ9bTeZIugver5yUBie4bHr7vieUe2HClFyc8Ipx1f+Lyb/4DIyiluSWnia1liNr9TK28L3
	MKOu6SRCPZK3gSNFMBGvg2JpDNY3Kt38eHzvb7RL7/qlucnUqbUDuEoJnO76I4SuDl/1GV1XGSz
	0S9VQR2UIUnaLGakPuLCeRQvmysJy+6T3lBxnZK7B2o/4FqKavSNXnULnURkloGA7MGA05icjq8
	+jju4ppY/EPGrfhZgtrn1s9LRmx5aTYDNLq95OdFf12/JIMYLWWpjqXrtBM2Fc3MCt/p2KJ6vl0
	J5dH6aYQ1yfOTcvjD1vyKu6xZ6vzpb+xsOVVFyP7xQyog3O4JM2pjIjogw67lIH1srSXKbM1s4G
	uPiLl/wzUzabmbG94dmZgF75H59eOSiiEN27gy9Cz8nPuBuHSqZuijZ8lshqjqYGrdUt5XHTnx4
	Gm8ONc5J1i1
X-Received: by 2002:a17:902:d481:b0:2dd:b83b:fe1e with SMTP id d9443c01a7336-2df7de9309fmr49802315ad.22.1790346241220;
        Fri, 25 Sep 2026 07:24:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df913e032bsm11754115ad.27.2026.09.25.07.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:24:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 25 Sep 2026 07:23:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"freddy.hsin" <freddy.hsin@mediatek.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] watchdog: mediatek: Apply the driver's mode to a
 watchdog left running
Message-ID: <559c625b-8191-439b-b613-d35afe24c4b1@roeck-us.net>
References: <20260923-rbrue-suez-upstreaming-mtk-wdt-dual-mode-v1-1-0970852315e4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-rbrue-suez-upstreaming-mtk-wdt-dual-mode-v1-1-0970852315e4@gmail.com>

On Wed, Sep 23, 2026 at 10:10:41PM -0500, Ryan Brue wrote:
> When the bootloader leaves the watchdog enabled, probe only marks it
> running and sets the timeout, so WDT_MODE keeps whatever the bootloader
> wrote. The Amazon Fire HD 10 (2017) bootloader leaves dual mode with the
> bark IRQ enabled, and no pretimeout is configured, so each timeout only
> raises the IRQ and restarts the count: with the 20 s timeout systemd
> sets, a hung system was reset after 37.95-39.76 s, and after 18.25-20.92 s
> once IRQ_EN was cleared by hand.
> 
> Program the mode as mtk_wdt_start() does, which also applies
> mediatek,disable-extrst and mediatek,reset-by-toprgu to a running
> watchdog; read those two properties first.
> 
> Fixes: bbece05c0d3a ("watchdog: mtk_wdt: Remove mtk_wdt_stop() in probe() to prevent the system freeze and it doesn't reboot by watchdog problem")
> Assisted-by: LLM
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
> ---

Applied.

Thanks,
Guenter
