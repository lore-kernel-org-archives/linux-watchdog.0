Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1019495035;
	Thu,  6 Aug 2026 23:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059847; cv=none; b=PXM9mTrznKNeBQgTiKbQ0Sye0hjT5VAu3r7v8Xqm6LNWW1Oi9Le6dJ1U+SSax+t9EDoBP0vwAkDS0OhJQla9uvO/98mpc6OlpwsCph+sjlnavr4UHWJv6SJKlt5zpqSN6D9Hc43vzG8eksuYxuaRR6WhcE8RlXBmChMGl2+TlBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059847; c=relaxed/simple;
	bh=0/W5nz+fbD+gLGE9lsFU0k9klACURcbIwaDrNrlsqAE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=R4hsV5xVoLbNaizQaMc8MglRNrB7m4eWYXvsnB+aXfQWZLX7pArz81tNl+kHtdpfF46rUjfFHJ73Jyp6vJ1lE2e51BF2cvM58q2UbDRhHnuSTLD7OC62Z9HhVkDbIKXjbR0tdqsu6plA77j/5lIPqsxbxxDB/DWeJ1GRtz+I69w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tmj5UBZ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tmj5UBZ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E410F1F00A3A;
	Thu,  6 Aug 2026 23:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786059845;
	bh=rQK9Iog+dZqpHKOtPxHQdcEmGMnI0+UlMPo/vsjFyh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=tmj5UBZ9ZroLrfUQQ+u9t9t91GehnUHEZxkHXqLYH3DvnQFVIq0lyvoFsckmg6wk1
	 9OMlxWJ/8GRpMIMN173PuXl4+vzNOMHiPLXq/7vkC3BXDRgFGuZbYXrhrVUGjL2Qze
	 +eVgh2NMbgsyQsvCyCKxAxddW8J3AMSRHON9jgbg=
Date: Thu, 6 Aug 2026 16:44:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: mrungta@google.com
Cc: Mayank Rungta via B4 Relay <devnull+mrungta.google.com@kernel.org>, Wim
 Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
 Tzung-Bi Shih <tzungbi@kernel.org>, Douglas Anderson
 <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/2] nmi: Export CPU backtrace APIs for loadable modules
Message-Id: <20260806164404.aca27fe3593bb5c95828807d@linux-foundation.org>
In-Reply-To: <20260730-export-cpu-backtrace-apis-v1-1-bace8e1cb817@google.com>
References: <20260730-export-cpu-backtrace-apis-v1-0-bace8e1cb817@google.com>
	<20260730-export-cpu-backtrace-apis-v1-1-bace8e1cb817@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 15:00:21 -0700 Mayank Rungta via B4 Relay <devnull+mrungta.google.com@kernel.org> wrote:

> From: Mayank Rungta <mrungta@google.com>
> 
> Currently, CPU backtrace functions cannot be called from loadable
> modules because the underlying helper arch_trigger_cpumask_backtrace()
> is not exported.
> 
> Instead of exporting arch_trigger_cpumask_backtrace() individually
> across every supported architecture, introduce and export a common
> helper, cpumask_backtrace(), in lib/nmi_backtrace.c. Update the four
> inline CPU backtrace macros in include/linux/nmi.h to route through this
> centralized helper.

Reviewed-by: Andrew Morton <akpm@linux-foundation.org>

