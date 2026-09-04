Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457C43B19B6;
	Fri,  4 Sep 2026 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514161; cv=none; b=FSEpWB7fXIgr4SGN8K8soDXmaf/xTlKUygN3Fl2HB/vDBJvGRDuDW1oFY0RDJyeGTXAJmLOr95tzNQmxVxbnmE2f52vNIGYPzFgYUazxSvhLtA8IBeGoVhvoO0ZoyfGhi5S+n6Oe5GqoYlUxhrdAyFDbs1R2PXZdAKzW8or7gqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514161; c=relaxed/simple;
	bh=N3YyRBdJKYkazfoXLU49zN4MLUTq+/sYY6lyhwhOGyY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eXG0/mLj14PyEl5X5QOpf/BqBAUD74wW3WBNfZMRUZOXdv07NXajnLtqO4mhtxVxT/6MOaa3jLRpgOkJJotk44YbYj5DObyMkE9cDLCeTN5oCWwrTbv3WfcmAcFQ9RDP5yZtJt3mUAwaJdq8ccuNDQGZJ/GfDXZ0J1eC9LbJ3mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tzoa29j+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tzoa29j+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470651F00A3D;
	Fri,  4 Sep 2026 09:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788514159;
	bh=p88M4xaIEYpXUcRPpkOl/PTYFJDK7ujN1bVqJnTp9YI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Tzoa29j+POqTESKUnuxucdGaEcnbkIfHlzTE9rquzrlkV6NvGczTgGM6GYF7i1sxS
	 lZXNvUEu2JJ3/xZzHCmVzBiaUaCsQ4/Fsgnpx/FNbf9qs/JlJXl830OLMF0Ny1ovrU
	 TlfbzLlVAv+PlReuWh80prNGEK5x8S/wviDx2zT5yn8MLQvwirbB9gLpzKBraE4+UH
	 Er567uvHO+nrZ0CNN72dmghxXK0Oeghjm+4U+v3dmKceb4u0bmO4Hyl0hWkqaLUyng
	 es+LCcFe7aUNT4M00+kEWZ7DFw43SxjLFfDymZahIYmwHWYX61uIDeX1CrD8wRv1io
	 xbYK9qIb7H/Bg==
From: Thomas Gleixner <tglx@kernel.org>
To: Mayank Rungta <mrungta@google.com>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Radu Rendec
 <radu@rendec.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, "Kirill A. Shutemov" <kas@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, Mayank Rungta
 <mrungta@google.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3 3/5] genirq: Export NMI APIs
In-Reply-To: <20260902-qcom-wdt-nmi-series-v3-3-f3999362a9ea@google.com>
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
 <20260902-qcom-wdt-nmi-series-v3-3-f3999362a9ea@google.com>
Date: Fri, 04 Sep 2026 11:29:16 +0200
Message-ID: <87ecf98ivn.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 02 2026 at 18:54, Mayank Rungta wrote:
> Currently, request_nmi(), free_nmi(), enable_nmi(), disable_nmi_nosync(),
> and disable_nmi() are restricted to built-in kernel code because they are
> not exported.
>
> Export these symbols with EXPORT_SYMBOL_GPL so loadable kernel modules can
> register and manage NMIs.

I'm not really fond of that.

Funny enough there is already a driver which claims it can be built as
module which uses these interfaces. Oh well...

> Assisted-by: Antigravity:gemini

I'm impressed that AI is required to add four EXPORT_SYMBOL_GPL()
instances.

Thanks,

        tglx
