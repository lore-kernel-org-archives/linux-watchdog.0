Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460064;
	b=ME/1eQamWt1SshIh1ZWX8VCsZpzuw4g+bh90AXSoo9O/xZJbNkbHQJZRbllXymsRHv3u
	 M8SK/8VtnvyLkVw0C2tHe2uaJ2RYDnD3/xgFe5Rz7xuDY9tZsigwWj4Raqs5jiqj36JN5
	 kbeSYNb2GP1mAO3GRoJXPXxForiLvQQNABLZNauLziaMxAe+BL3pkuDZ9IWgiZSUeGjUt
	 pBOBEOvcORM6WI9WCqDQsWcGQy9t3T9i2VGIDLHeInBGebOWJLPpdFzZK6oy+Vv7oacje
	 aOgrDybiEkvYDK+MJsRS7DPnjun7zNhHqTiYSma9mJ+ySb/OkQ08gK+R+EbEb+HJ33g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=lgcBWl0zj9yWJYZJtO20mhEVTw7e2l6L5r66HTPC7Zk=;
	b=0o1S02Kk5xDuMoO09Kh72rHebdM57og41Xgxj7CLHWgPKxLjYpEdSIGyKnBtDaUhHRB6
	 XdXnFg6XM8CXaBwEUpuVKdbUg5bhaxHt8GICngkVECG7sze47dz2XgucFnUqGoqDBYFM8
	 73qkFkX2Qxk99zewSkV2a1rXOa4HB44pq4xoHwsaa6br5iEAScJvwxaACGH75jODj/LUd
	 fG1NybvVYDyg7F0/3+9cv0C8/id4Iec+8RZjrDekOHAegUc+SAH3bip/zsDUqxLM8828L
	 z5xNSVB2Ar0078pkzBL0WpJc+mUzb84UjD9XqRC6+qj4zuPGjKy+oevEJOr++Ns5VkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GZdt+J6C;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BA1606A31A
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 01:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2BA1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GZdt+J6C
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso6596193eec.1
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 18:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792460063; x=1793064863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lgcBWl0zj9yWJYZJtO20mhEVTw7e2l6L5r66HTPC7Zk=;
        b=GZdt+J6CBL/Jx2mWmXdSINlLG8x4mR+njCSqzzzJj2VXqEibomN6ViUwBz2LnPmX0B
         PQIoWLjTRWMbQm8jsXYY1RW0k5MniDwMqry4CyeTOug4xOREKx0iULC3qH1AUmxwB5AI
         AXbISyhkgiNYOsWmdVcgHd64WwtQqYZ4F+uNrI0Hn7svLy6mGzvEzj00F87J3GBx1+uR
         x93lxnpzoFK1CUea6sSOw1DoFnSlZ09mnJMp5zQ5y3rmldeDpROy2emAHksM6Kp+wOM4
         ZT+tlcKuPOzWrkRnY7BRQv6QxSUyJ4BiGMp69pOp9SILLnOYeDxmwlfC46GggibYJIas
         7ybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792460063; x=1793064863;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lgcBWl0zj9yWJYZJtO20mhEVTw7e2l6L5r66HTPC7Zk=;
        b=glfZhaWW5MOizDCYXV40r2YY6BkNB5FoCVvT16xD7FtQWmNgOZuarUrn0PEQZEF4iD
         WJ57qWKse+zldhj9ic2xX8FXT0rmwGFGHaWmueymelYTgeGgeha2Kc+NOto9UdB1TAPW
         SSPchWdzXiOD3CwR6ga18mLcY6UuMnaSN6AsUuB3CJJvvatzVLffedLC4TZRzozUi1iy
         4Skd6QoqzCIqx3fqaje0JfZMpNTG4iiGfJcc+NpDBKF/pby9etlwg7m40gAoiUtS1Z37
         UqSDHVzQyxcmJUe+zHfvMNla1XwnZFwa33FSK1mwbC7DDjvmLed0ukFzNH2NFGXQoYqd
         Ldfg==
X-Forwarded-Encrypted: i=1; AKwUvBy6mHpmRHDhsEJIq8LVYLtkZygxEJCkuHecSqdUG8XVzmxeF0KGlvXg8MrpSbgg14SjTyPZBIoyp1brroAawA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLfTo1LbPJmGU2uvYlse1KiEAQPQB2xtAX8pLNKEG2NzFYiCTOv
	fawqDmJ/0Pce7pb6vrXF4ZV3Knnx3zeFGC21WODXxy29rSPsuLF8obiQ
X-Gm-Gg: AYBFou1vbQpUffyjtjFYb1fGiL+6CyWMYhkn0IUIepBagHFOCu0Dn1X7Z+5jW7SfMlS
	OJ9oGY2p+e038ba5j1uKkXMlDDZdqdJJasBVz+JonvKVpLs3CoNef+Tp9/q7H45zq5K2ViUr2XR
	hZ2XrsXZv/j7HdoadL4UiuNQBdAMYe3pfw5vPRqR5NVSRvPq7tg/CG2vpUkmbTiBCYdQQPMBIwb
	yopiuVlzAD0uT65g13c2itBEqqB3m3dJ4azApm08Yr5LksNU/CqT3jQyaJi8m6cYRhDPL3PC8zU
	ixpYdSxWFhz2EOVezdfMJ0/8x2C2WNjrK82VciiPl1duDanmsfwm30SlRdL82i6b5uo1b5X+NB7
	+vARXuTbY+oh4zyxzXEzrpyEZULgG0p2gRBxTHjTNnFpaM4z+09EInvBLTem+O5IMWgpDGwN2K+
	B4ovkgHczNWTfQ84aYzzXvXr82FYF5tUwZxLm9kzfuv6DXlo2LxGfIzyMqrg88e9+p1zpG9jvDU
	uVTq23NT+rG
X-Received: by 2002:a05:7300:ce0c:b0:35c:7d45:c6ea with SMTP id 5a478bee46e88-361a2053aeamr13372981eec.19.1792460062920;
        Mon, 19 Oct 2026 18:34:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0d391sm36624354eec.4.2026.10.19.18.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:34:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 18:34:21 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Igor Velkov <iav@iav.lv>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] watchdog: orion_wdt: stop the watchdog during
 system suspend
Message-ID: <1cce7809-dc7c-4ea2-b985-d3ece252fdea@roeck-us.net>
References: <20261012-orion-wdt-suspend-v2-0-f13cf71443ba@iav.lv>
 <20261012-orion-wdt-suspend-v2-2-f13cf71443ba@iav.lv>
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
In-Reply-To: <20261012-orion-wdt-suspend-v2-2-f13cf71443ba@iav.lv>

On Mon, Oct 12, 2026 at 03:46:57AM +0300, Igor Velkov wrote:
> From: Igor Velkov <iav@iav.lv>
> 
> The watchdog timer keeps counting across system suspend while the
> userspace that pings it is frozen, so it expires and resets the system.
> On a Kobol Helios4 (Armada 388) with a 60 s timeout the board resets
> 47-61 s into s2idle, whether the watchdog daemon or systemd's
> RuntimeWatchdogSec holds the device.
> 
> Stop the timer on suspend and restart it on resume when it is active or
> running in hardware, as sp805_wdt does. orion_wdt_start() reloads the
> counter, so userspace gets a full timeout after resume.
> 
> Assisted-by: LLM
> Signed-off-by: Igor Velkov <iav@iav.lv>

Applied.

Thanks,
Guenter
