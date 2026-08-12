Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DD042885E;
	Wed, 12 Aug 2026 10:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530915; cv=none; b=K+c8vD2YdpIfidDNVma7Txvi41Dy644kpebxBoMKWPpVgp5exib3sNhfCIMZw1CmJ0QSlaQ52C6S+5+dY2RzNzvOayDHG0Be6P5TTGoWlkg2ajz5d93iRXzY+Nm78otmllWt0xdt1153gQzbCkmzZLuPi44fBJcyAs2Ksn/SGVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530915; c=relaxed/simple;
	bh=YW9hcKOUsr1ElpBbC60bEqEanfcJJuZK5jrxQ+X2FYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNApzyHjT4RCFlDtU9BpYbOfl3Ewl1JUUINpMSmnn5jCkCWib5/uijoUra0A5RZ5gInqP4oe7r+/uIecWTJHluYVGXYKF1O5Vhss9SIBpHCnL92YsS3Z/E78jLwObijNQ6qFGrg4Lwxe8rO2PiCPipVFOzC2+1K7wEU6UYSyboo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfLkYVyf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfLkYVyf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F911F000E9;
	Wed, 12 Aug 2026 10:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786530914;
	bh=KqmtgzPBncZEMRO2d8cE2MGb0LERXNEQmTQuzXuj/AI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AfLkYVyfGTIYmy+S7st1151b23Xy+xY3bWWxuaVHuqqo/z/0IXC4lEcFGRR0VWwQw
	 i81X2EBDwaKXpCWtvaOK+XT0MJ9mmbMi7gqRBSuCGCZ3mk1hc+yzsArgjTri6jEiWr
	 yCELNoUO/63kQ5Guz13iDRsdzhpE0uPiHkujZDXgaOsWK2h8YvS7JOPoRJA7wi0SJ7
	 JCUE/2/u5CNB6EWqcomUEeOuKKkHFaSrXJ9aYvT08t9V6etLmzhAcJfTykOxsAjQIa
	 cWA/DDCz6VWJYqc7LXJ7VD3Gwenkewi7aLhZvA6ign4LCWvvAVLm4rQn676EWZvu/O
	 jqIlpDPi0PITw==
Date: Wed, 12 Aug 2026 12:35:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/8] dt-bindings: reset: Add mt6589 toprgu reset IDs
Message-ID: <20260812-smooth-artichoke-kittiwake-f6e85e@quoll>
References: <20260809160643.33991-1-l.scorcia@gmail.com>
 <20260809160643.33991-2-l.scorcia@gmail.com>
 <20260811-amethyst-seriema-of-gallantry-ca9c7f@quoll>
 <CAORyz2KXJf4gU46649w1ncb7TAOErdoGmfOMzwKr8b+eGdAgVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAORyz2KXJf4gU46649w1ncb7TAOErdoGmfOMzwKr8b+eGdAgVA@mail.gmail.com>

On Tue, Aug 11, 2026 at 04:20:11PM +0200, Luca Leonardo Scorcia wrote:
> 
> > We do not take bits, but identifiers of resets.
> 
> Currently the existing mtk_wdt.c driver does not use a reset table
> that binds identifiers to bits for any of the existing devices. There
> are a bunch of mediatek,mt*.h files under dt-bindings/reset [3] that
> point directly to reset bits instead of being indexes.

Many got accepted unnoticed, many times we did not care, but the point
is still valid - pure hardware numbers do not belong to the bindings,
because they do not bind any pieces of code. The proper binding header
constants bind DTS with SW implementation, so two pieces of code. Not
applicable here.

> I can introduce a reset table in the driver, but it would break
> existing devices as those bits are referred in device trees and they
> are often non-contiguous (e.g. [4]). As before, it could be done by

Then these bits stay as is in DTS but bindings header is not needed. You
can have of course DTS header, as we did in the past multiple times for
such hardware constants.

Best regards,
Krzysztof

