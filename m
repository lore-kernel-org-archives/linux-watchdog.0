Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C01A2931E3;
	Sat,  1 Aug 2026 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785587940; cv=none; b=McRnF5oHDc57Drf0IrrW0JVSZAaPS3TyK2yU7G2WsPfOa8UpHugSzvCitcf/by67q6ii6wADJxHwnhmLviR5q268U6NZIgcMamZDD/GOPuSnNZZUpyvxsXZtVaZmFc3S6JllJeJas7uqOBdyWbyUcv8HUhBaA3vuXgiG5YP+Ks0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785587940; c=relaxed/simple;
	bh=e0zta6I54wNoPl0pJ5Dj2C+u7Eb/IUsRA04ibQZU4yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUovXdgNNaH8CckB5eYI8Qb49HadAhhYIRSDDAjKBnR0EEyb+3LMy+RSmfVE7dX5C/Z9BaaxozEPSjR5AsfviAfHnUSc+OsXSY/0xgtS6ruWIS7Dw+1iuNeIUY6SulR7H2/MKcO9rb4w+jr7dxCAzy492gAWuLcqZ/cB1YtVaMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5xjy5EY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5xjy5EY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9A71F00AC4;
	Sat,  1 Aug 2026 12:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785587938;
	bh=kl2KSAngF5PDfiE5HIZsOP3lzdcxso2Lk5vcENp//8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q5xjy5EYy/JXYRm2xyK+FxRGYHXAtBTsrI7FkqE+tX+/D34bhypPGyhvN4uqNP1Py
	 72GOYTwFJCxc0sbxqkPME84JIOtxRYtg2705+NptJtINF7LdL552LITM2cbO46B7y9
	 EKvQCFgXpAC/33oCrkeKwZTVBEgUB5eRYRn20ddT0R+i9n0mQhSpYNQKdsb7JJnKOV
	 XiMTCQqpwjZsQ9iR2/+a59FCHM/N7jF17oZ1fTyxQW0CCzR4eJCJ3Fe2NknapQ7tyP
	 TStkxFYpVUScf8QYWmu3C6PuaLQFlPwzjL2YcqvNlnh/34dM6x51tIwN1Vu0iO5/dC
	 B1NieFUTBc7lA==
Date: Sat, 1 Aug 2026 20:38:54 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: mrungta@google.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: pretimeout: Convert dump pretimeout
 governor to tristate
Message-ID: <am3o3rvyy5QtRNjX@tzungbi-laptop>
References: <20260730-export-cpu-backtrace-apis-v1-0-bace8e1cb817@google.com>
 <20260730-export-cpu-backtrace-apis-v1-2-bace8e1cb817@google.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730-export-cpu-backtrace-apis-v1-2-bace8e1cb817@google.com>

On Thu, Jul 30, 2026 at 03:00:22PM -0700, Mayank Rungta via B4 Relay wrote:
> From: Mayank Rungta <mrungta@google.com>
> 
> Commit 645ad41da8b2 ("watchdog: pretimeout: Add "dump" pretimeout

FWIW: The hash might have changed due to a rebase.

> governor") added the "dump" watchdog pretimeout governor, but restricted
> it to built-in code because trigger_all_cpu_backtrace() was not exported
> to loadable modules.
> 
> Now that CPU backtrace APIs are supported for loadable kernel modules
> via cpumask_backtrace(), convert WATCHDOG_PRETIMEOUT_GOV_DUMP to
> tristate. This allows kernels to deliver the pretimeout governor as a
> loadable kernel module.
> 
> Signed-off-by: Mayank Rungta <mrungta@google.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
