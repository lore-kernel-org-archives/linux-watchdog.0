Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B588137D12E;
	Wed, 16 Sep 2026 03:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529288; cv=none; b=EgDzrGW68PpnGJyop5TjCVSfNNCr6q5GzTwGIC7xhNSG7XFScbCj+YaoOubtqtMYAIvkV+A4Xyg805mqVP58amU7vP5F/sUkt63oxanvBE47uZEarbOsI68l72CEr1GhPsk0bbrGLCQB5nALobeMTGFMK6BH/bL/31V3NT4gLq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529288; c=relaxed/simple;
	bh=ZCFHsS0P+LN7wbVxp+NTof9Fmk/O+N0CvCLeoW/i6E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5kVvFwmb/YcPpzDvkSfQFKaO811jHoVANwBeeDilDj6W+1rz0myJUTEiAS9O7L08DB5/OSHxSXFSnLcSL6k8vQ7QAZEZnSBcoNI2UDYb10671/knIBEAQwSiGBx3eXIqD9+T+y98goiTiX7SXv5YZpjMa5/thWFHxDZ62blNT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqQUC7pE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqQUC7pE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507461F000FF;
	Wed, 16 Sep 2026 03:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789529287;
	bh=UiiSLQ1FY7PGF8Iwx3A5tXMnfUwiCyXoobKNhtQy5Zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HqQUC7pESIvANB8HZXICxXI7IWV+a28wre3vKh4akyk6Q6kQ2N+AE2wtbEQHmD/Dl
	 U87reThDHrr/gp9oaGYTZd/spGxIaELsWipQpr6zP4Dd4+/+CWplonpzgh9gs+371Q
	 VOjY4xcuf6yBIW2SnznTIclIvNAzg2UlrM8rtbdaJ7sXPQg1Hp+v/cnpQFfcPrCVhN
	 dbowSt6aMOzApAUmQrCr87KSLSG3NKo3s4ZfIE9txa7MW2BftCNc1UDraY7nIQd1Gm
	 DcoDQT2fYNbhEyUTrdUn7ojFWtCpyb93Hb484y1z5co+VUNsxn78wMoZWAx9FpbHgh
	 1krhpwA7zwE4Q==
Date: Wed, 16 Sep 2026 03:28:04 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: linux@roeck-us.net, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org, wim@linux-watchdog.org
Subject: Re: [PATCH v2 1/8] watchdog: cadence_wdt: Convert to
 DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <aqoMxDnKCOARllQC@google.com>
References: <20260914085451.891675-1-triet.hoang.dev@gmail.com>
 <20260914085451.891675-2-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914085451.891675-2-triet.hoang.dev@gmail.com>

On Mon, Sep 14, 2026 at 03:54:44PM +0700, Triet Hoang wrote:
> Convert deprecated SIMPLE_DEV_PM_OPS() to DEFINE_SIMPLE_DEV_PM_OPS()
> and pm_ptr().
> 
> This lets us drop the __maybe_unused annotations from the resume callback.
                                                            ^^^^^^^^^^^^^^^

Not only for resume(); maybe just "PM callbacks"?  This suggestion applies
to all patches in the series.
