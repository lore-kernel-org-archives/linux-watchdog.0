Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B821547604F;
	Wed, 30 Sep 2026 11:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769278; cv=none; b=g4wAVi5lfTrA+NrcdvQSEKcrl3xfBhYmgv06wf0roDSuk7GvAYf7XsO4FvBRnXNSjrb4x1STapfrCPG6lEJDyw6S2rjEQcVaET7d3Btyyth2H5TZhXNP+r8sA9TarfQURc8FBQl0kKGgecrdCgIlbun5FhHDxlPC0sLbruzBtu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769278; c=relaxed/simple;
	bh=qK1B68x/Nyri+uNviroMWKKUVPWDktqarfYXn5QYQsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nmi/EI1wfr+GodrA/CF/CGLd3HyxRUo3YAo5GqJSGC4G30VMA/35QxpG7+aDMwqyfUmdawSe6nvHxMLU6qDM2BzDPLTlAtXLDiFEL+N68vZDM3GoWc2QLPn6bZBxATBOTXP4gBI0/v4qSobS91h9iXQlnEWxQq4Oxrb1uRSr2wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMrLkihN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMrLkihN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83BC1F000FF;
	Wed, 30 Sep 2026 11:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790769273;
	bh=2JdCR356q+lUkLL28eGKX3AVKctqzzhDz6i51WzRPJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YMrLkihNe18jII4tHuuilyXeKwbRmo5CyXcQIfSFXQpT/WjwuAVEwpfSw6/qDSVQN
	 IbodIRQO15lkVSqWO0MXpAqUj6HMK2uikdE3z7Z0sBj8UwLtGNV6xxNMngXJhH8Sec
	 pMS0Klj5BqNKp6JUqZOem5htX+5+nJSQn2qb5tM6iVCNh/MXNihsmAbEpoYKNifoQp
	 0Ks40qL2VG63NuVALWXgI2Dgh/Kc73Ppy/S36lC6V4zrE+Upvyq5+y1OmuvqnKGQsC
	 N3ZJhwuYi/bsF3sRk0Fdd4Sp9J32J2X2xKyppE1R+BLf8YECHGj4nWLico31otv3ps
	 9sRktZ3VaPboA==
Date: Wed, 30 Sep 2026 19:54:30 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] watchdog: core: Cancel timer if cdev_device_add()
 fails
Message-ID: <arz4dllgWSG0uIv5@tzungbi-laptop>
References: <20260929134635.2567137-1-linux@roeck-us.net>
 <20260929134635.2567137-7-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929134635.2567137-7-linux@roeck-us.net>

On Tue, Sep 29, 2026 at 06:46:33AM -0700, Guenter Roeck wrote:
> If misc_register() exposed the device to userspace before cdev_device_add()
> is called, a concurrent watchdog_open() could start the watchdog and arm
> wd_data->timer as well as the pretimeout timer. Also, if the hardware
> watchdog was already running, watchdog_open() expects the device and module
> references to have been acquired prior to opening.
> 
> If cdev_device_add() then fails, the error path drops the device reference
> but fails to stop the watchdog, cancel the timers, and stop the worker,
> leaving the watchdog active and timers armed that can later fire and
> dereference freed memory. Furthermore, if a concurrent watchdog_open() saw
> hw_running == true before cdev_device_add() was called, it skipped taking
> its own device reference, allowing put_device() on the error path to free
> wd_data while the file descriptor is still open. Similarly, when
> unregistering a running watchdog that is not currently open, the extra
> hw_running module and device references were never released.
> 
> Fix the problem by initializing wd_data and taking the running-watchdog
> references before exposing the device via misc_register(), stopping the
> watchdog and canceling both the heartbeat and pretimeout timers and
> stopping the worker on registration failure, and releasing unclaimed
> running-watchdog references on registration failure and unregistration.
> 
> Fixes: ee142889e32f ("watchdog: Introduce WDOG_HW_RUNNING flag")
> Assisted-by: LLM
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
