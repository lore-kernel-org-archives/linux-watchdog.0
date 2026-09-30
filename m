Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23234B1D1C;
	Wed, 30 Sep 2026 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769199; cv=none; b=gmBoYLgxxKhDkTKi/g1FB27ku/341UyAJqGQ5cU6PTHi6AjmmJJFN/lUbHTu99ITsGk9A7GgU54SjG2GyVkQJs9z/Z7OPOOKmOH49q3HZHFKpCj6XSn8WdA0z6CbUEA7fWRhlgDvmaZEqYS8h3L2dZbZyA1LAW15rIYKSGQNQ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769199; c=relaxed/simple;
	bh=IXy7nAPrgHsHSHbN0XM8CJJjfvqtiWirdKHp+2aM3dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYY3mA04L25QqI6dPhWtoStKwj5v+YxGypcO25KRloNWB7HN4Py3Et1pH+ZRpA1EfawAq7YK6oBLlkT6b9sMU839CjU6DbmNMHpI40yelhiguDCWXATjf5Rss+J/CiOEbMVSrz3btpWMEYlVsetEqW/9pInE+WmlAeK/zWBWLwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0nFyCG3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0nFyCG3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F83B1F000FF;
	Wed, 30 Sep 2026 11:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790769198;
	bh=7TPl0oqAExPehZAQBAmMe7RLxQ48Ot/PMyhKwok1au8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q0nFyCG3jvcvsC9ypooiecA8+tlxG7mGybWbJ2GPiRfKV83jFEgAPkIZZJHVkMm/s
	 RCwu+MedIGoa5EDNn9vl2UYFzu2Eq/jFPs0D1dHN7oYQgseU7z0yJpAzXpz2DLxUY0
	 ECs7k05EMRgGtId3Pqlvt2fZtb7lcnyYfbmJ1ADHV1wSRIhT/LTwG22eeNdFPWWS86
	 hwbVrgqUTSzmelf472ZIv2zvUkE5IuZFy2IrQWDUifPDWgsm4JnyCiXMcyiBQx88QK
	 PBbfcrbDn4eUejzsx13uEBcasplF2hgaD5PIz42aySt0QEMTq63q6gBmcAUFKK8fXR
	 vfdYDejZem2uw==
Date: Wed, 30 Sep 2026 19:53:15 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] watchdog: core: Clear wd_data pointer on errors
Message-ID: <arz4KygdnfldRJ18@tzungbi-laptop>
References: <20260929134635.2567137-1-linux@roeck-us.net>
 <20260929134635.2567137-2-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929134635.2567137-2-linux@roeck-us.net>

On Tue, Sep 29, 2026 at 06:46:28AM -0700, Guenter Roeck wrote:
> In watchdog_cdev_register(), if device registration fails after the core
> watchdog_core_data structure is allocated and assigned to the persistent
> watchdog_device structure, the function frees the data but leaves a
> dangling pointer.
> 
> During device registration, watchdog_cdev_register() links the newly
> allocated wd_data to wdd->wd_data. If a subsequent initialization step
> fails, such as the watchdog_kworker validation, dev_set_name(),
> misc_register(), or cdev_device_add(), the function cleans up by freeing
> wd_data via kfree() or put_device(). However, it fails to clear the
> wdd->wd_data pointer before returning. Furthermore, if cdev_device_add()
> fails after misc_register() exposed /dev/watchdog to userspace, a
> concurrent open may hold a reference to wd_data while the caller frees wdd,
> leaving wd_data->wdd dangling.
> 
> Fix the problem by clearing wdd->wd_data on all error paths during
> watchdog registration, and clearing wd_data->wdd under wd_data->lock if
> cdev_device_add() fails.
> 
> Fixes: b4ffb1909843 ("watchdog: Separate and maintain variables based on variable lifetime")
> Assisted-by: LLM
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
