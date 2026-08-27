Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4F635E1A3;
	Thu, 27 Aug 2026 07:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787816568; cv=none; b=MSoR6Y+AAf3A0+/kB2M2T5gIShOhAm+z5ujAO4UOIVG2gFI6Uge6IwVPstdzb5Fac1y3jFQa3x03gFzMHpKZGp5NSDhDwzONZxhoCQPtBlv6c8+MPTmO83w26wOZiWeIYwwEwXbeVVPjH9Pz3lX7MQl48Ohyr4Rx2K8ekbA3qn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787816568; c=relaxed/simple;
	bh=i4oJUunTQ4iz9IbjRnoyThrOmv0d7lICCcuS1JnsSrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWMjtb/th7KR+UnIlkIpzmmOPz6IZ7twImr+ySS+ihpw4CuYj1RH2YE5zIzmPHZAhW6gMXPupcsVo6afzoPlAl7hn04q0C+5sMs239vKUi8N5HP1cgTIx9K93Vvq6xxO/qRJHSs0R//LdaKQf1V6nINE1JF8FJgrVG3sUAv8hrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeDmv1Fh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeDmv1Fh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239251F00A3A;
	Thu, 27 Aug 2026 07:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787816567;
	bh=QfzVKBvWTVBiEmaZ9fcYZIqUMU7AyLVTIgCmQxV6EfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jeDmv1Fhbeih8G4iQfYTlcA87ReXHdEAkilg+kxYGD/aMiEOXw/J4w8+OG2PgpzCp
	 /t2w9EifJjTYVNXymzXx9URVxyLk1SIL4CKHJsdUunqb65autx64yCuDR2vdKw8JfO
	 be1NrLZmTdovwjbc41jxas9X4AfckWb/GhIlmSaacmuMTRtg2EghaFHhXQeZmO9nKD
	 WnUNLuP3UdRnHmKBtHAwoGdm2P1Me36flloScFpGRuky22a4865H0YE/hXtxZQuTXq
	 /7hggFDuP0QR1sFV/HOAY151FOiufKIws0EY5jxNpLnHmBXt3MUpWGq9N0IMfZceCu
	 xC8Xd8j7Wylsw==
Date: Thu, 27 Aug 2026 07:42:44 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: wim@linux-watchdog.org, linux@roeck-us.net,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] watchdog: da9062: Convert to
 DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <ao_qdLdFmcyIkLM1@google.com>
References: <20260826060839.203297-1-triet.hoang.dev@gmail.com>
 <20260826060839.203297-3-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826060839.203297-3-triet.hoang.dev@gmail.com>

On Wed, Aug 26, 2026 at 01:08:33PM +0700, Triet Hoang wrote:
> diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
...
> -static SIMPLE_DEV_PM_OPS(da9062_wdt_pm_ops,
> +static DEFINE_SIMPLE_DEV_PM_OPS(da9062_wdt_pm_ops,
>  			 da9062_wdt_suspend, da9062_wdt_resume);

To be neat, it'd probably like to align the parameters to '(' or simply
combine them into a single line if it fits within the 100-col limit.

The suggestion applies to all other patches in the series as well.
