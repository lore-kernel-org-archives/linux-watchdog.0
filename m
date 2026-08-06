Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921024A8210;
	Thu,  6 Aug 2026 23:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059868; cv=none; b=PQu8cO4/VXbLuZm0iq8XTNC8+k7PDFpWETKtxTbgZ5sVEjSgzn2xgKHgDZ4U1hAcExeZZxsfPDYanVbPZgBqviNYLabxCeAec2hOY/W+Q75lDzxa+AfK/mFXbx59wwC/SCMDwVxCBOqLeqKfWfVMsGKLzSxOznVgoZZ5u6Q3WGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059868; c=relaxed/simple;
	bh=BpSJ5aju+uXgnqYChuTg6lM+JOCha0ZK1b4rawTDUL4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iWz+0IdSRP0NBZfXjaWuuXpk9d94SdoJ5bGUAqPUWJhcyw0PrZ0g1RHP125MdNfY0Zhi1u1/ny07G8i30f+TrAq51D9OeokjLm7pI+jVnyapZdkv2liR2Le7MApR4hWgN8Y8waxoCL9WW1A5FnE+rpt40br08ybWQ/2Ov3oVJcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uWrJg+5h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uWrJg+5h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24A41F000E9;
	Thu,  6 Aug 2026 23:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786059867;
	bh=dKPaiNt4bvrNXTusd9JfNItGLmdNO3yUgO9/xYOwJNE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=uWrJg+5hfBLNJIXRPhkQYqH1c/wDIuFpMq1p4MTaoLkV/HyCmVOR0OkK4IN0iqoqQ
	 GEQmf4Lxvmn/ahP9dy3sKLDcnfhyshn3dX5iTrFxx8MMuuKTX+DP9HLWZTZonPA+vm
	 jH2W/HDg8+o8l3wBkiQdESAmreChbCwIkJMy5Wlw=
Date: Thu, 6 Aug 2026 16:44:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: mrungta@google.com
Cc: Mayank Rungta via B4 Relay <devnull+mrungta.google.com@kernel.org>, Wim
 Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
 Tzung-Bi Shih <tzungbi@kernel.org>, Douglas Anderson
 <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: pretimeout: Convert dump pretimeout
 governor to tristate
Message-Id: <20260806164426.beb8464cf72d31a79e68ac60@linux-foundation.org>
In-Reply-To: <20260730-export-cpu-backtrace-apis-v1-2-bace8e1cb817@google.com>
References: <20260730-export-cpu-backtrace-apis-v1-0-bace8e1cb817@google.com>
	<20260730-export-cpu-backtrace-apis-v1-2-bace8e1cb817@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 15:00:22 -0700 Mayank Rungta via B4 Relay <devnull+mrungta.google.com@kernel.org> wrote:

> Commit 645ad41da8b2 ("watchdog: pretimeout: Add "dump" pretimeout
> governor") added the "dump" watchdog pretimeout governor, but restricted
> it to built-in code because trigger_all_cpu_backtrace() was not exported
> to loadable modules.
> 
> Now that CPU backtrace APIs are supported for loadable kernel modules
> via cpumask_backtrace(), convert WATCHDOG_PRETIMEOUT_GOV_DUMP to
> tristate. This allows kernels to deliver the pretimeout governor as a
> loadable kernel module.

Reviewed-by: Andrew Morton <akpm@linux-foundation.org>

