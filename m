Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036C0329E55;
	Thu, 30 Jul 2026 22:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785451824; cv=none; b=IiBesd6yg8+Ag0n/zcu3ts4U2dCtvTz5nOYj8j0KvPgA8tAczLIACL00sx47ta7qe/rOZiV6yTpokYvaTgJZlnUbFaEzH76PLnaLtVjAT+/Lq2t7BfI9S8ymskk1vc4xhOFQSnfS8joIXHTLTpxjiYsM6nDvLeZZRezDamW1KG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785451824; c=relaxed/simple;
	bh=C5S4NjuXl0lkvf/BoAyk+sTHY/ZI+TO32c/y4gROg18=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=otOyTZgyQ4Tq9saKcmP88MW9BK8audwevxk1du+0jX9yC1vHWaNrpu6/ss77RV2bHOHMkb13Mval9lKMFQfeyd4x9JENRN/97ftDqpWsmz2RZaYqFUPuTGQMfkWiNoFCGWB5AnEeXHguN+trMmUiVZyPfBsBXI4OKS2ND3NNfJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CGbvnC1B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CGbvnC1B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4601F000E9;
	Thu, 30 Jul 2026 22:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785451821;
	bh=Zwu/wQmyKjL/GhZMYgeH9le6y0VGyGDkvj75/3SXb4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CGbvnC1BZbUe2pFzE+QVt0smyZ5H9Sl+wm7Pt9XMMDLlp8MysLW8iRkD32SzmbKP9
	 TJq6di+OFeHcmThn8f2lB88AWFuUz0+TS/4xLCcQTIV1G8b5GP1twbt2fHtjPZH8SP
	 HBfGSQl0xKIqJSK5Gjq3QpWVFI2GjCU8OHupTQ3E=
Date: Thu, 30 Jul 2026 15:50:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: mrungta@google.com
Cc: Mayank Rungta via B4 Relay <devnull+mrungta.google.com@kernel.org>, Wim
 Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
 Tzung-Bi Shih <tzungbi@kernel.org>, Douglas Anderson
 <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 0/2] watchdog: pretimeout: Allow building dump governor
 as module
Message-Id: <20260730155021.8252ad9d155b472702e66755@linux-foundation.org>
In-Reply-To: <20260730-export-cpu-backtrace-apis-v1-0-bace8e1cb817@google.com>
References: <20260730-export-cpu-backtrace-apis-v1-0-bace8e1cb817@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 15:00:20 -0700 Mayank Rungta via B4 Relay <devnull+mrungta.google.com@kernel.org> wrote:

> All other watchdog pretimeout governors (noop, panic) can be built as
> loadable modules. However the "dump" pretimeout governor is restricted
> to built-in code because it calls trigger_all_cpu_backtrace(), which
> relies on arch_trigger_cpumask_backtrace(), an arch specific helper that
> is not exported to loadable modules.
> 
> This 2-patch series allows building the dump governor as a module (=m):
> 1) Export cpumask_backtrace() in lib/nmi_backtrace.c.
> 2) Convert CONFIG_WATCHDOG_PRETIMEOUT_GOV_DUMP from bool to tristate.

LGTM.  Can you please redo against current mainline?  The Kconfig has
changed.

