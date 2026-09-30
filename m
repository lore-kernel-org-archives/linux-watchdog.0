Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024E3476067;
	Wed, 30 Sep 2026 11:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769250; cv=none; b=JaEb+hIhRKDnYmEw/qcEJLQGFyoKPIqsTTgyQIrnn+quePGkp7FnKOhv9ljfRg9vxdm4S5y0dNbBHlKUdOXKpzmY1RMUOfEpPoJfCso+GSdCmTx8n0clzECU+3aABgX9q2mSp3Ub31MutKwVFid1qlpa3KTRM8nTW46QrU5Ek5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769250; c=relaxed/simple;
	bh=PvDOkZgj3fcFwebAo3a5u9ubTaX2ut2qNjotF5b7T7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCY/nuiFBwSsoC5UkdICiWjbTyRgNmGkFaDEt4NaM7yHdu/rN1Zv3AeQZHOq2sO/ed7xj/EeKe3Mm+3nR52vOHaQIkC6pOZIea5azwQ4QMYymP9v8l/KqPIPn5m7KN8e9b8lTih4QS10Zy59bHfBwcZQnwb19zHBeBiAdrBtwHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iD0NhBV7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD0NhBV7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EB11F000FF;
	Wed, 30 Sep 2026 11:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790769247;
	bh=1umxcvCrmbyvjHx/u5OU8OqGl/G1rBicm//gAmMOizE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iD0NhBV77oqv+iPmmRPqRNwwH4TPBXfoON7vzcsxFQ3NfXoqzJBhUyAlzPBUNZ0ZO
	 3VFcDKpkDPahIsUk+u510SyPT2jD/STbhwlnq8Uf4fAAycmf5uBRcDZo/xzUfa2SPD
	 EwEzmOji7F1TysofqTWww8B1hqhphDx20p0ynA9CeaIDs3Je3h0BoS/9M9tvFQlopB
	 Ka5BcKzvlcMcxeizaDo9tkIdTSgn2csZdRzwIWfpCXzCR9bPL4ysqY9dTfJu44Sd/U
	 w3xvzQxTCyuTY+26oiaRSArEdoQmLCPvurdpwmut0MMfWV6FkCL5rty/ShcileYZ9Z
	 vpu5igvYvxkXw==
Date: Wed, 30 Sep 2026 19:54:04 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] watchdog: core: Stop pretimeout hrtimer on suspend
Message-ID: <arz4XIm0vpWsD-97@tzungbi-laptop>
References: <20260929134635.2567137-1-linux@roeck-us.net>
 <20260929134635.2567137-5-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929134635.2567137-5-linux@roeck-us.net>

On Tue, Sep 29, 2026 at 06:46:31AM -0700, Guenter Roeck wrote:
> During system suspend, watchdog_dev_suspend() pings the watchdog (which
> restarts the software pretimeout hrtimer) and stops the keepalive ping
> worker, but fails to stop the pretimeout hrtimer. Because
> CLOCK_MONOTONIC continues ticking until the system fully suspends, a
> suspend process taking longer than the configured pretimeout will
> trigger a spurious pretimeout event.
> 
> Stop the pretimeout hrtimer in watchdog_dev_suspend(), prevent
> watchdog_hrtimer_pretimeout_start() from starting it while the watchdog
> is suspended, and restart it in watchdog_dev_resume() if the hardware
> watchdog is running.
> 
> Fixes: 60bcd91aafd2 ("watchdog: introduce watchdog_dev_suspend/resume")
> Assisted-by: LLM
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
