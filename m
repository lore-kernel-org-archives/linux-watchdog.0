Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CF73E44F6;
	Tue,  7 Jul 2026 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420094; cv=none; b=lG86YO8wDjphixPUrVUZ5HAkEuKN+5DirKhY8AFTstTU7STYGnhqxJCdldajz4b973bVRrHVjPTC6imOvJJJX8dP5pIo5uxSiSvCWB6lSI6QXZRzL2X/EHFRr1vapUi4mo/YFzaIsydh3euyn6/bkWwzCPFdhnq7RMoM7N1d0pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420094; c=relaxed/simple;
	bh=lVg44Af1qRFRKeJ8/VQGOmUd8KVNp4WLYt9KebgBoM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqJlOKmt/SGM9hpFMqR/jd3UE8e9t1+K/hTknigPjipgU78Bc+evWgz6R6KnUCd4Q/pZ+EEc/X6kLBipRZXrqvu0JHzkJgkQprbeUwhz3gPw24G0/ez6GNP+EGR/WpXZzGkDfTks0pd/wOePyz7wtMU9uFdxL7Ibcywt5aO2juI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6E7uGvl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6E7uGvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288C01F000E9;
	Tue,  7 Jul 2026 10:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783420089;
	bh=j1aLtMBfaDu1F/NGu5OUF/uTqiElGSc+jY39CO4JD68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e6E7uGvlPV3+N6s9fv0Q9bkGF4FBoI3HBh05tG1syp67QY4noURRqhUcwqZ7LSyRM
	 UxaHZGu10v7E+aqoo7C3QjqezsiQmeiG9rvYpMXXRswli3I4lEYYmB2Yq4667A4r9s
	 oltBZM0msiaVtA2H8Lxn0NhRdCd2hQlME5h1cY9MUE7PSKSpbL91Uy3W96A5v/0+Vq
	 VvubN4c2pt9NSi3Ll1gDQHfubEMSC/MHNHMhxJfZGrPI8VfcKxcF0nsZ8iUZAXCPd1
	 bXIJPaRRFQaMnZc3EOjCbNxeXx6AJ1EZBaGDtMuoJ91IC4rN+kP5+iHthvN7kHlu6Q
	 koECGPqnAmbGg==
Date: Tue, 7 Jul 2026 10:28:07 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: pretimeout: Add "dump" pretimeout governor
Message-ID: <akzUtxGzCslsJL1l@google.com>
References: <20260707073117.2962676-1-tzungbi@kernel.org>
 <20260707080225.4C52D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707080225.4C52D1F000E9@smtp.kernel.org>

On Tue, Jul 07, 2026 at 08:02:24AM +0000, sashiko-bot@kernel.org wrote:
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index 08cb8612d41fe..7b291ea8b0f01 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> 
> [ ... ]
> 
> > @@ -93,10 +93,19 @@ config WATCHDOG_PRETIMEOUT_GOV_SEL
> >  
> >  if WATCHDOG_PRETIMEOUT_GOV
> >  
> > +config WATCHDOG_PRETIMEOUT_GOV_DUMP
> > +	tristate "Dump watchdog pretimeout governor"
> 
> [Severity: Low]
> Will this fail to build if compiled as a module?
> 
> When CONFIG_WATCHDOG_PRETIMEOUT_GOV_DUMP=m, trigger_all_cpu_backtrace() can
> rely on unexported architecture-specific functions (such as
> arch_trigger_cpumask_backtrace() on x86, ARM, and ARM64), which causes a
> modpost build failure.

Use a bool instead in v2 [1].

[1] https://lore.kernel.org/all/20260707102105.3600275-1-tzungbi@kernel.org

> > diff --git a/drivers/watchdog/pretimeout_dump.c b/drivers/watchdog/pretimeout_dump.c
> > new file mode 100644
> > index 0000000000000..c5d3dac2606c4
> > --- /dev/null
> > +++ b/drivers/watchdog/pretimeout_dump.c
> 
> [ ... ]
> 
> > +static void __exit watchdog_gov_dump_unregister(void)
> > +{
> > +	watchdog_unregister_governor(&watchdog_gov_dump);
> > +}
> 
> [Severity: High]
> This is a pre-existing issue, but does unregistering the default watchdog
> pretimeout governor leave dangling pointers?
> 
> If this module is set as the default governor and then unloaded,
> watchdog_unregister_governor() attempts to reset the active governors:
> 
>     list_for_each_entry(p, &pretimeout_list, entry)
>         if (p->wdd->gov == gov)
>             p->wdd->gov = default_gov;
> 
> If the unregistered governor is the default governor, default_gov equals
> gov. This leaves p->wdd->gov pointing to the unloaded module's struct.
> 
> Could this lead to a use-after-free upon the next pretimeout event or sysfs
> read?

Proposed a fix in [2].

[2] https://lore.kernel.org/all/20260707101803.3598173-1-tzungbi@kernel.org
