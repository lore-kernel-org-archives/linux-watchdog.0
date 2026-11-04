Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776361;
	b=Jpam9vTzYn5+Lt5yhA4ZJCsjQi5A7DRwXMffTj8nND5Rbr2rnrZ9hY4WDPiXssGzM5Dq
	 T1KJPcS3Nd3un9P+Xxqytaj1BpYoYU9/LBR9pKReQ/bs3SQNdo/4fD4qx7o5inP0o0tG+
	 Uo7pKzyJJBKjg6YRF3VjWMSt7eNw5fs7sx4oUrfXWvAIkq+IYZYVpiH5ehq+Blnlyu8Fc
	 kYyuhXJkCzbNdgGuvb4WSwpiByyE7iUAGx1SjjLXslC7iCbXrEMi6V4ibuaGeo0z3RXwV
	 AeRa1wwTjU1kW8PQtgKraPfrsFI6Q27xF5wFSXEmyRS5q7uXrwgTw6O+DzUB/UpfYtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776361;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rNvGQickLKty4kKFnH2z6Q3YUpQwh4zaapXTQbwz4DU=;
	b=pxhd/Z/8VweRgC2nE6zSLQeWk1Ko1qqzfJMMdn49JEtAvqRWNxmI1G+/3XLyp7w0BIdX
	 f2Op/xZ9WxPnh/ChBZ6ex19vt6p+mbYsEinTQAxK5rmqKi789BinwpF5hOJI7xPJNmOHq
	 Lh2kTioEgPKrHJNt8R+8yadNaA5WiV7ExuRoxplzdns5m/xYh/Zk0sbw+Q0hlmlFvrIEr
	 HWb6mqkLmKZZYiCQnFETRewM+1dqywBLjD9JEO5du0bOfMHkRAoh59K3eWuwxHxyFHrXO
	 2M+CXOjNpCSGoYPeCDBRKvUQcpVEsFqPoTWJlW0mZcW9UiHPmEa/731pAQGsbQ8q2Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8EhBO29;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11929606A329
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 07:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8EhBO29
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26AF1F000C1;
	Wed,  4 Nov 2026 07:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776360;
	bh=rNvGQickLKty4kKFnH2z6Q3YUpQwh4zaapXTQbwz4DU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P8EhBO29bPJlVccLQ2g3ZepY4ryo3wQOQApZOX+lMZvU3EnyBN+MFBCoISIpYmVGa
	 y4N6L6IKyyLziBq5UTT8wpMjplQ5+jqjFp/Dak8m4Z6u06vkFHVhddqk1i/AJDxjaM
	 eKP5NTV1tcCD1wf0ehOR66fpuvq7OuYRtr0owkrCYadG6bnor+yOtqObgLAjzijdYR
	 H5eIkS5wsSQuO6FtB6ab4c2KRNcMhgSTWRLRUS8ATuulzZHqJUuWr6oq3YI9SKN8lb
	 J/rgEP+NmR/dU6H0iQvUgjSX2H9jdVmzev+Osl/CZ5iOzO+bm+j14fRhKkAntugQNa
	 RsPAliRDlYJrQ==
Date: Wed, 4 Nov 2026 08:12:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, 
	Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Re: [PATCH] watchdog: nv_tco: drop the PCI device reference on
 failure and teardown
Message-ID: <20261104-gregarious-carmine-fennec-9ceefc@quoll>
References: <20261104021545.1468838-1-vulab@iscas.ac.cn>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104021545.1468838-1-vulab@iscas.ac.cn>


On Wed, 04 Nov 2026 02:15:45 +0000, Wentao Liang wrote:
> nv_tco_getdevice() walks the PCI bus with for_each_pci_dev() and keeps
> the reference taken by pci_get_device() for the matching device in the
> global tco_pci pointer.  The driver never calls pci_dev_put(), so the
> reference is leaked when nv_tco_getdevice() bails out after the device
> was found, when nv_tco_init() fails to register the misc device, and
> when the driver is removed.
> 
> Put the reference on those paths and clear tco_pci so that it is not
> used after it was dropped.
> 
> Fixes: 456c730153fe ("watchdog: Add TCO support for nVidia chipsets")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/watchdog/nv_tco.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 

Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




