Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792459959;
	b=dxD/7BSSNtgH7Fn/6sux1bK7WqjOnPCIDM2gDzH+s/8GJ8gmsjZgHzsQJWzn3ItppVP/
	 En2fN0nb7Mf8FKxs5bykSSHxEe11QMYSAZeMDtfZqBTBcsxomqfxTaWuiYwD8amhlXSyK
	 YeTX+ekm5rtG9r85K5kqrveTPJt7+yEZHIr97EsNpfXoQmqxDhjdw6dxFXtSNgKJ7WNF5
	 C4wryRPOJQtND0fxxpD4Ki01OzY6UUgo58FSVg0iD8CfGcdOjtuj+1MmO8LxgdIvz9Gn5
	 HCwIotglHoguerR+nAL/KIe4QY798C4vPrarbloxtGhit+yaWhFewdif80vxdEip7nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792459959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=hbd8F40uztWUFdFpYoq/NguOmu7kZM7kx6LRdC65rBE=;
	b=wt8OVI2cfYUuB+Cn6P7YO+SGIFn2xxaXmlHb4hq7zB8h+Lw4o7/lz+CJqvLwC8qKSAKG
	 i8NW8Or+h+TMPgdoqatBXqRutKpdlV6hy9LlakwZeCfZ7XhZdUHS2gwoCN8HNpwLKrppg
	 4ECSbijo3zRFZ8kjuqeHnONmZxCW50JJHFkBjIUkhYSEpRzB5/TbyDXnvBETrLpXu+UoE
	 Bnoe0TryoSba5n+ljL7FMphlt7kJsFTIcAq1g1fEVRZjcz3PCyU1iwxS2nOzVAkgJaw2a
	 tfTGeGMJPTE9H3u318ckERe+NjcNlPU+9mNISsY0bJklwFge1MBuKfCFVW83lQ74mkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mtq+eZFd;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABD6606A319
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 01:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ABD6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mtq+eZFd
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35ef6b49813so5114157eec.0
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 18:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792459958; x=1793064758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hbd8F40uztWUFdFpYoq/NguOmu7kZM7kx6LRdC65rBE=;
        b=mtq+eZFdhhS01ky0+kx1VNw4MweptzQevrl1PWVnZAr64+3HZluobbKHYk/ulv5dlr
         P0lTY1ep/oueixqy9Wm8m0UHp9e9JRZPS6UN7Jf44hZaIklHxJxNIotKNEKfCsO8Ewux
         bx1Z6XXR4sHSy13Enr+1CMwXyqdDA4douiJSxf4AUX8LRA/1ZlgMT9gyatufVNuPdJdm
         Y0azE4OtpnLolOTb+1ISPXZNZfod3NyvK72LbIa1eiMpTjH2UAmq7ZeitHoBxNcAqWC/
         UA24BirhpP0FmVJaQE8LjlOm+n5MYIVQpcVxa98QXfw6xv96FWLToYNOLOgIKTo0gJLP
         siKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792459958; x=1793064758;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hbd8F40uztWUFdFpYoq/NguOmu7kZM7kx6LRdC65rBE=;
        b=VNoP7CtFN13d7aYG57EIi0c2Ly7fRqXpJcaj21q8uSXsTy8wHdBRqhtRiyeqTbB7/m
         xb102KbWYf/qpuQHFrzObZ8emG5l7RGE+vQbilFTiUVqTtY0QOzExkb0SfukYBUnjmce
         EaMQZs08QPNIsq27s656pRKfcDqSETu0tC/GHIxmNxzYHBKrqYuPdMaEOVMGdANMeBOq
         L1uQb0J7BsZqlFMqYnlixMRhCD4j3djJx5TJcg5ThQKqHQdvGpyd6YFCT3KyhrDL9+lA
         t6l9/FcezVL3PmuW7ivMZWLKc+SvssPdZLoDhQwyxPzpoOz6IigDQcrt4KJtrOe+QoeO
         o1Gw==
X-Forwarded-Encrypted: i=1; AKwUvBz6MJ+yFYQtQGXEBdQruKiMR8tp1DnUQR9wrsJyVRtzcpU+jD/BxLa/GHkmu6Tso5tJFhxEsZOulh8T95cHlg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJoDlGQT+yDaiVH2enC/x1oCDad3ktiY3e7eQieisoPt4eS6z+D
	Xh2s14o4SVkeNPkStJzbXYR+yc9Im/5UGdg2K9LFR6c+sErQiNlltB6Xn6qlZw==
X-Gm-Gg: AYBFou0ZlpZvaqYjufCCqbHe9BPCowDK3AfW9Z1Y/ccupRmJEIZRzwzRfkVQ/Ozd9NW
	Q7VGBGjq0rze5NjnQfgTw6W+YXW4/vQdjObvSmp8YCnEdqXAsJ4ukX52Oi76thlT96KDWKpaGTE
	NfC34tgbnUGgDKvLpfiF55SQODzO4actZ38YD9gy49oJpWS6GRsbjQzD9vwHInkeIqcS5Wm0iCY
	x4uECTm0B5TcgGEsuv7T1l6xHV/Coj2P+tBZAh7lrrspTHzUhnXE01dDTCpsv/EZSfqkwLG2fQ+
	X8bxVqHVZtTLzOIotXlHrpM9w69eKcjt8rcb/VypG/6x6vplzf4xI+vuidON3sqyLLDdINAIHWU
	AlewbrbgJr+rb0XxKb8uN4YW+n5NSJ5j2NMuKAAXu1cavgm7g9oeXO9Z4F+QyZZvk214EdikXUP
	ovaImyE5P3GiYWdWOSo9J/2G3IeZ6DMkr/kXTawlyymhRk6WyiamufSxK4TQVz+AaKSxRijsE7t
	kuZ4f3OIDAJ
X-Received: by 2002:a05:693c:87d9:20b0:365:b147:b458 with SMTP id 5a478bee46e88-365b147b492mr1958916eec.3.1792459958338;
        Mon, 19 Oct 2026 18:32:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6ca5sm33999595eec.9.2026.10.19.18.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:32:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 18:32:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arunmani Alagarsamy <aalagars@qti.qualcomm.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: davinci_wdt: Fix typo 'occured' ->
 'occurred' in comment
Message-ID: <31336794-97d3-41ad-9396-865cdb4e7f6a@roeck-us.net>
References: <20261017164403.2987788-1-aalagars@qti.qualcomm.com>
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
In-Reply-To: <20261017164403.2987788-1-aalagars@qti.qualcomm.com>

On Sat, Oct 17, 2026 at 10:14:03PM +0530, Arunmani Alagarsamy wrote:
> Fix a spelling mistake in a comment inside davinci_wdt_get_timeleft().
> 'occured' should be 'occurred'.
> 
> Signed-off-by: Arunmani Alagarsamy <aalagars@qti.qualcomm.com>

Applied.

Thanks,
Guenter
