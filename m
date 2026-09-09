Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108BD3CA481
	for <linux-watchdog@vger.kernel.org>; Wed,  9 Sep 2026 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986661; cv=none; b=snF14TJMbk0xSA+naIniGK8tUfqYyrCiwTPUkWGRuq+LglYjvtJZYSQSuJd0UJAWCS6SZOzgppgXU1wCOrv/46ZbJLfi4QbceOyA0PcKj9U8HZEQPXN8nuvIL2Irwti1ubJqKHgpxE0jKnxTkkxbL4JC1KTE+QDypu9sZxDJD68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986661; c=relaxed/simple;
	bh=50nCYJPjbqQUb9GuXVSadJfp9i5nwJt7sQqIe3gmZNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkiNRp4WHliaT38K12oN+AxobgJLGh/V0BbByAsz1xV0N3OVFnmb50yyODT9vyjqRmFL8OLeRABmMcYfebTV49stfRCUSc3c6A0Mtgm2TB2fqJZ2fio/6g+8DDfzXRQyoP8anHU1KtbenZ0DOxKPGLQVXT8aHbkkwNqQeuDtbZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyQmSBlT; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyQmSBlT"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4b28b358eso86739a12.2
        for <linux-watchdog@vger.kernel.org>; Wed, 09 Sep 2026 13:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788986647; x=1789591447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C9fkP2hJvytILEzpGHVJRqCYsbQTF7+11HBlBKosjXQ=;
        b=DyQmSBlT9Q/L8ySaZ190Qb0hO5LHTaUHDL/8x7plTZLIJOMCSAE/UyiCGeD0+7UK3F
         /RtnZU/JvN9PZAYLpvFmOEBrmw6I6uu0F/4BDfaLAugx6gN0tr2ly/5CNc9FrzkedC/7
         7J7MMD8JPafiiZ/SXYiBbzqdNvf3NCd1ly3C7Roy0jIU/fPBsCQ5bLXzBNFlgNL2oo8v
         Ve92+ckWqFZkPwhUOBcI3x61px4tsYng4pg2CXuMgcIunqLh2LF+9uYuc8uSN8lzwSL9
         NGhicqv4GZEKmSIYCY/vd//6rK6dMisIchmXUlc9n7NwgcRuusMy7oaewzpltD51O4sQ
         gqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788986647; x=1789591447;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9fkP2hJvytILEzpGHVJRqCYsbQTF7+11HBlBKosjXQ=;
        b=RWjygNwQEY5T+ozixkhukOMwPnGEz8v3Pn6vjzbNrL8aqTtJ6/t/7r9FY3+NKggCKA
         s9dIfXvjOS8IV+88O3PiDCilb1qb1kwscRbtJv8JyykLX7X1lOPsuP4ZmM2CfvtPOCxD
         9gBUXNrv1EqFXhmlp4LGAOPFAmVRFG1V2Uh2CCBJHBDIjRKX5lOkHtq98Xefba06oxDm
         vHswATAK+wDqqxxJLjdBieqo2xg0K2vKudr9LphFyfuEjrNp1ounx2dgy9fwzr9wR33U
         9sqWV5NLxtLwxOPyKu6Ac7diwAiUtXZmSaz4z4mzZyNOUncRNSgsEreWNkfCDwzttHez
         nU7A==
X-Forwarded-Encrypted: i=1; AKwUvBz0mxuecxW53a3XJXjYxMUgCssXNkWeg1qmgXsMJSGGgk8VkIwy5QJiqXabsfm8T6cCJUNm32oxNPOFDqukOg==@vger.kernel.org
X-Gm-Message-State: AFuF++nFalYquv+eI2+nqUvHSXo6LXyz3KONzeUVJcQL+Rpj9RvoHt7q
	JeJNIbwQfmByljUcKVGjjs/gc2UO2HZAloUFfKebO8mrOG38l+ca80GiPBQRRQ==
X-Gm-Gg: AYBFou1vX2Ihh9D3W+ecgghbhUrfpd72+8Y/bQkboUUyaLo00r161YqaI5Q4PrbNA1W
	2mf3R8lXt3m4jnih8/eO6jHTyRNbeq8So/Z6ERHPRhDwTmpNtBJGbG95XOeO8vXK1JiQwwv9BPI
	1XeyHnsRDNNy0U7QuUuSXr+i7+g3aMcvD1A5S/IGFA2Ww2kCGYLaiuzK1TTQ4R3nwL4wASaEPD/
	3fuK8FRMGwyIdYTcFtxxx7Q0YC4Kjh7eSOql2Pr6fOQDQ3qO3QQj1Oprqr1/+z2Nc7aC+gLqanD
	+MLHo62rNDEMcnuuJw9J6IHF/ARkwf4AYXwGWFhLge5NPBHDSvwh8CTXYi26uuQ4fxCpQjOAEkL
	Hjkn+U/rkqZ/52CgG5IONomY/p6MFP2qGGKGr/2v/KIvuHOotuCwQKHQ16bLdc1qK38Jzhfte9S
	aRr713CE8UXtmsDkZhYvKnY9pYs8Ob2uqJ4B88MNW6YfHmAVl0q9x8AYY8PsSoKIhPUdLlntk7j
	IUR3OhUvgNx
X-Received: by 2002:a05:6a20:72a6:b0:3d1:e510:905f with SMTP id adf61e73a8af0-3da39b3a6b3mr52747720637.1.1788986647535;
        Wed, 09 Sep 2026 13:44:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc45542dbbesm7256657a12.13.2026.09.09.13.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 13:44:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 9 Sep 2026 13:44:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: i6300esb: do not stop an already running
 watchdog
Message-ID: <b52365f7-27d4-4c5e-885f-65413c7d2bd6@roeck-us.net>
References: <ea413e5d-9f37-46b8-8d93-863aa065a784@siemens.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea413e5d-9f37-46b8-8d93-863aa065a784@siemens.com>

On Wed, Sep 09, 2026 at 01:15:33PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> esb_initdevice() unconditionally disabled the WDT, stopping a
> watchdog that firmware had left running instead of taking over its
> care. Detect the enable bit in the lock register, set
> WDOG_HW_RUNNING like the other watchdog drivers do, and simply
> reset the timeout to the configured value.
> 
> Assisted-by: opencode:Qwen3.8-27B
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Applied.

Thanks,
Guenter
