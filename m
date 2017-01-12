Return-path: <andy.shevchenko@gmail.com>
MIME-Version: 1.0
In-Reply-To: <94c4d5c0-f639-eab1-6706-335977690e88@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-1-git-send-email-linux@roeck-us.net> <1484100561-17638-5-git-send-email-linux@roeck-us.net>
 <bd56e90c-5cb8-02d8-3518-c8f5483a6df4@sigmadesigns.com> <94c4d5c0-f639-eab1-6706-335977690e88@roeck-us.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 12 Jan 2017 02:12:39 +0200
Message-ID: <CAHp75VfUUJaCLXgZ+jNj18ZEMXSNnaw6UvEZcuP7J22apojPYQ@mail.gmail.com>
Subject: Re: [PATCH 56/62] watchdog: tangox_wdt: Convert to use device managed functions
To: Guenter Roeck <linux@roeck-us.net>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Mans Rullgard <mans@mansr.com>,
	Thibaud Cornic <thibaud_cornic@sigmadesigns.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Jan 11, 2017 at 12:52 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 01/11/2017 01:07 AM, Marc Gonzalez wrote:
> Not really. It would just make it more complicated to replace the
> call with devm_clk_prepare_enable(), should it ever find its way
> into the light of day.
Actually what is the status to the patch series which brings devm_clk
stuff like prepare_enable()? It was submitted 2(?) years ago.

-- 
With Best Regards,
Andy Shevchenko
