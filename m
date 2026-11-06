Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980276;
	b=F64BciFp+kGv5VdtQ2l+NrHIfXkyc8hRAPDrjT86zNCzgFOnxWN4NSgIZZx/Q8bwy6Dr
	 5Y6LBxifRsugbSPF9sehuBH1WT/dWLBH1mA3hQzPCzzDKic7WjXSUzJOLAzbVBrBllZ4n
	 3r0QXMXPl0GB5uKslT3gZ3geyYE5YPLnN/UnPZenN/sR7EEjR79BpXWJs0U7ufFxaEJxc
	 7S/NjbbEC37IbHkyhVxS61If5sGtFz+XslqGW1sgHvMZsBCojWW+557v8H9fWmDQM6Yu0
	 MBuAkPkdgD9O8LFvxZWuX6oNkDdfVvOqzXp4HkefqbEy79SPERUK3TT6kK37SaOOjcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980276;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JSe7HF4bkQTAX+jjM/aEwC5ZvlKLqv5gZsI7tYbLJUM=;
	b=h/1/8EgE0y4vceVu24uvltWdmjryGXDk2IHLEFPK2TS9poPrWNOtcodL4gGEa3d+5c07
	 vmrSca3GqQL6xcceTahUVh8/dhHovWiwmdRmkquTnEkoFuHvSFemWTb/REj++OhjHCdZQ
	 g4sYxkM2iIm1JOmeL5fhRMIHT/4nvSJOu+2gwCdxjp7Yk6K1PqoWbZoZb3xEv3LDTCblX
	 AOiqXofeUeBIxtof/gQ7N7aqZ4dCIaELDBYwi7rawpWc1gzixABkwl85PBduwjFj1Oh8o
	 bwdwAKd8BqV+xaiHe3TTV04iPvBHuIbW47HoDYmPoFs+30Rqf2xpujqm6weyXCLpUxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hth0dbEs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736F9606D804
	for <linux-watchdog@vger.kernel.org>; Fri,  6 Nov 2026 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hth0dbEs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420641F0089F;
	Fri,  6 Nov 2026 15:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793980276;
	bh=JSe7HF4bkQTAX+jjM/aEwC5ZvlKLqv5gZsI7tYbLJUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hth0dbEsu231O9IW5oM09YAJRRLdv8A+dFsqkFIR/6aRfANrAaa1eLPdzvPiIrnYF
	 1mccX4hk2qQIrRQy3mEozMNWbHZ6aas/3LHYZ8RD7XzxXnUe3P0uFaiObdsvULNE3+
	 MNpe8gZJbSv8JuDASFBzwb669aeckp8/g+6kklvx2PLXW6wYmuHi7zeNp+uGRjTkuO
	 CeuRLePWx7RO9o7Cv8rARi85Vv8XLt/8OcFwFe6f1+EuinsF/NCdbbj54A8sVfQQcC
	 9MJ4u2qzbayLbwW5TDsrxNi9OM+NbG2HKCfBMZ+Tk5RnfzeEvPUJW8QN1YmHOmHFe6
	 cm7huWsLvAGGA==
Date: Fri, 6 Nov 2026 15:51:13 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: [PATCH v2 8/8] watchdog: starfive-wdt: Avoid unclocked MMIO
 access in starfive_wdt_set_timeout()
Message-ID: <au33cWt0e0UicvX6@google.com>
References: <20261105190530.2371854-1-linux@roeck-us.net>
 <20261105190530.2371854-9-linux@roeck-us.net>
 <au3ibSdPUIKvUWNa@google.com>
 <43513761-1e49-4fa0-af2f-fcbffddb4ded@roeck-us.net>
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
In-Reply-To: <43513761-1e49-4fa0-af2f-fcbffddb4ded@roeck-us.net>

On Fri, Nov 06, 2026 at 07:20:32AM -0800, Guenter Roeck wrote:
> On 11/6/26 06:21, Tzung-Bi Shih wrote:
> > On Thu, Nov 05, 2026 at 11:05:29AM -0800, Guenter Roeck wrote:
> > > Only program the hardware registers in starfive_wdt_set_timeout() when
> > > watchdog_hw_running() is set. In addition, reload the initial counter value
> > > via starfive_wdt_set_reload_count() in starfive_wdt_start() (preserving
> > 
> > Is the additional change relevant to this patch (i.e., avoid unclocked
> > MMIO access)?
> 
> I think so, since reload_count is no longer set in starfive_wdt_set_timeout()
> if the watchdog is not running.

Ah, I see.

> 
> > 
> > > wdt->reload on resume) so JH7100 loads the configured timeout into the
> > > counter when started from probe or after WDIOS_DISABLECARD.
> > 
> > Is it really JH7100 specific (not for JH7110)?
> > 
> 
> Yes, the other chip doesn't have a reload count register.
> See "if (wdt->variant->reload)" in starfive_wdt_set_reload_count().

I see.

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
