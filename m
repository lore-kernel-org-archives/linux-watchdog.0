Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460966;
	b=zEio4Q+4fgL9mlBTyjrqy+zaNe34rBLROEIfAvktii5kQMQG9goSAG9Pyyod4Pbork3X
	 zgoXru7g8LDYq7AqIN5k8ySsbuuzwSMz9zxwF2BZlbdZVL0jDcI3vxDcZ/MU/7wxNTfsx
	 gQlHLmDoUAyh4prez/Sh5W2/BCTQW0ZVk2PPhlxHLwS0FyOpEj5UeaYDo9LKystpDNKX9
	 5Mahevf3/gTm4GSUuR22mlBkSm1lUdhdNbNTtWwvRulEMETBqm41JuCc0Ak45uwYgs9vQ
	 PKhd+BfzlJ1EUSJ1+znVeF8bIwz4fgBGbavdgVvHK80vtDa5cbba6yOycifIe5QzLTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=GI1sDXL68rILFOS5IDyHXobc25qpbCh5q48o7ZrhuAs=;
	b=m5ZwMwYjqPV8xwJL2/JhCZHBR7tZrcE5oY2qWHYlOuIOS3JWoAo23GF/c3VYPIb7I++B
	 +8dNfHw/zaUhPE/Hy0iBK7HrCNuHb7NpmYIR6o2X5AmNCcGTAEj2IMuKa9PADISSyoPRS
	 Vd5Zxr+k6+6/mfcPiI0VTs3nttLvQNJ7Fso5tU8Px850xrZq4s+dQAa9I8/ksBsZTpyV4
	 SZXH+UQJd8kFZdBtHjWejUl+vdad0baM7jN6CzupfeDh7uDVlyksTUs8I2T2EIcXHhPxi
	 OsUlDSrCbQVEQcsvTBHYekbP+goLBmQTARZAcJGQd8pEzhGE5RZXS9x3kqNTezdYb7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j5Zy+06H;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAF2606A31A
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 01:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAAF2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j5Zy+06H
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3550c917fd3so3240719eec.0
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 18:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792460965; x=1793065765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GI1sDXL68rILFOS5IDyHXobc25qpbCh5q48o7ZrhuAs=;
        b=j5Zy+06HYvqYPzoaj9knMK1wL17L7UbkhFY08X6bji2CwTZ2KbbiifP/KVdX3Q9z5W
         i+kgyZBG44OKtizVXUD99kmzJp2OvnzAMYVWr5palMY9td9/HrRCXsmA3eMzEdxDu5Gk
         YK9u4n6eohz7cYvcSYbcO7NsQ9ybecgkZ+0xYWkmdZODUJ4Sie5KL+wi+UxjZANDgGcc
         Atk7lkyfdFm525ZM7UNE2j75qevy1ibAc1HiXz8Kw4GCw59TEFlMvo8VfV/ujbGlds0K
         7RhpU9WeZm/cHO7MOIqBM/lrAxknTs7UruX71kWhte5U62tSO5m0qdWwsiZdzwfsaR7N
         187w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792460965; x=1793065765;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GI1sDXL68rILFOS5IDyHXobc25qpbCh5q48o7ZrhuAs=;
        b=nzh7O03SdGjmnQM40lrrJKFsE+RtPhKzuoAAMecmYM858uQVQV9NtYqbLhqF9wOxnH
         /DMPCTXwpTgZWWepD2PrkYmJqWIdlghlfZJceOQwF2raBcqd8+vGooAzEedHYPaetXSz
         f9choC4FWHANo5ZMffCqKthV6L0RbbRzL/wqj4GDeuk4vxxP2fP9CdKjJpAIVxlJZeWq
         /j3JPrU5KgAp1wuXr82IFLAgj/pLS01cokeDIpZAgk7T0VZsoXyn8WV/bEQZKZM+3onZ
         yTsK9tSyDadYi8yCMVil0f+/cTyt6ScVkB9zdhjTh/28PFaozbl/v+PHfXt5uj2LBSAB
         pjtA==
X-Forwarded-Encrypted: i=1; AKwUvBwEypt9eaRZWncxykANUecv9vmiILOJOVzQRiODSMUl8swaPeJxSgkmVIXzVIz4y2rakoynJUvq+ZvPKSWr3g==@vger.kernel.org
X-Gm-Message-State: AFq9FYKQkFpPhplNbGDlrgF23sITiS0kkheNGAT+BD0gtxsSYhclGOOT
	DiCJ4xG+8wXc1QwzBX/7hgKEVJUqplBNUCPFFwpC8iscXIwQ+CigsVHj
X-Gm-Gg: AYBFou1QFBFUFDUrvT8yHVKFKGGHbwG3w79GW3hyXpjCSej7/IOk7+jFkxGa4ISl+zQ
	OJqOx3edxLpd9HFea7y/vtsYdPoSu1o020eHhb3cOJkCToBfd4vq1h7CiFtCMomhjyp9J4HYKi3
	RrGbF9SogTvtXBUopbmD8y1RI/GodOeHloVG13gobekW0YxG3kd1ytA2zQSW/PYrc2IGbqXmzwP
	Lwh8qEfkrhfDUishjoaKsMWCIKgjm/PnwGtFrwkZzUqyji4EIL0s0m97fvHN4XyANMxxfde7q0Y
	pr+95OvDwr1pUp/PwAPyxA/MFGDHNH7WUPT1REGMnUpUYDRyvLqxK9ecEltQcZjicjX7fmvMcaB
	aVP7w0fBMuQOu645Fc2OsCKaBi8k9es4FiKCP/6rhXiekubLKuWtSRSYsO640omNYxOmNwBPoXV
	AXtEbLJIsVZH/TDcOT4LUZILYNFYce+ww2vUluYxuCOxD9eoa8Dg1aJ0zK/ejtE0vmt6gkDNj/U
	JToDKqNrtJX
X-Received: by 2002:a05:7301:271c:b0:35d:b452:902a with SMTP id 5a478bee46e88-361a2942d31mr14312652eec.34.1792460964928;
        Mon, 19 Oct 2026 18:49:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082784ec8sm33941191eec.22.2026.10.19.18.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:49:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 18:49:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Pablo Mazzini <pmazzini@gmail.com>
Cc: Chen-Yu Tsai <wens@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 09/11] dt-bindings: watchdog: sun4i-a10-wdt: add
 Allwinner B288
Message-ID: <0ed8c1ac-1f9a-4cc0-b914-6b245f86d296@roeck-us.net>
References: <20261005202731.153971-1-pmazzini@gmail.com>
 <20261005202731.153971-10-pmazzini@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005202731.153971-10-pmazzini@gmail.com>

On Mon, Oct 05, 2026 at 09:27:29PM +0100, Pablo Mazzini wrote:
> Same watchdog as the A31, which it falls back to.
> 
> Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Applied.

Thanks,
Guenter
